/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:arc_view/src/authentication/model/tokens.dart';
import 'package:arc_view/src/authentication/storage/token_storage_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../config_loader.dart';
import '../storage/token_storage.dart';
import '../util/auth_util.dart';

class OidcDesktopService {
  final TokenStorage _tokenStorage;

  OidcDesktopService({required TokenStorage tokenStorage})
      : _tokenStorage = tokenStorage;

  //final openIdConfig = OpenIdCredentialConfigFactory.fromAppConfig();
  //extract config information
  final issuerBaseUrl =
      Config.get("openid.credential.issuerBaseUrl", defaultValue: "");
  final clientId = Config.get("openid.credential.client_id", defaultValue: "");
  final clientSecret =
      Config.get("openid.credential.client_secret", defaultValue: "");
  final redirectURL = Config.get("openid.credential.redirect_base_url",
      defaultValue: "http://localhost:9876");
  final callBackPath =
      Config.get("openid.credential.call_back_path", defaultValue: "/callback");
  final scopes = Config.get("openid.credential.scopes", defaultValue: []);

  // Initiates the login flow by spinning up a local server and opening the browser.
  Future<bool> login() async {
    final completer = Completer<bool>();

    //Get URI&PORT
    final uri = Uri.parse(redirectURL);
    final server = await HttpServer.bind(uri.host, uri.port);

    server.listen((HttpRequest request) async {
      if (request.uri.path ==callBackPath) {
        // Extract code from query params
        final code = request.uri.queryParameters['code'];
        if (code != null) {
          final success = await _exchangeCodeForToken(code);
          completer.complete(success);
        } else {
          completer.complete(false);
        }

        // Show something in the browser
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.html
          ..write(
              '<html><body>Login successful! You can close this window.</body></html>');
        await request.response.close();
        await server.close();
      } else {
        request.response.statusCode = 404;
        request.response.close();
      }
    });

    // Build the OIDC auth URL
    final authUrl =
        Uri.parse('$issuerBaseUrl/protocol/openid-connect/auth').replace(
      queryParameters: {
        'client_id': clientId,
        'redirect_uri': '$redirectURL$callBackPath',
        'response_type': 'code',
        'scope': scopes.join(' '),
        'state': generateRandomState(10),
      },
    );
    // Launch the browser
    await launchUrl(authUrl, mode: LaunchMode.externalApplication);
    return completer.future;
  }

  // Initiates the logout flow
  Future<bool> logout() async {
    try {
      final tokens = await _tokenStorage.getToken();
      final refreshToken = tokens?.refreshToken;
      final accessToken = tokens?.accessToken;
      // Determine which token to use for revocation
      final String? tokenToRevoke = refreshToken ?? accessToken;

      // Revoke token from the auth server (Optional, but recommended)
      if (tokenToRevoke != null) {
        final response = await http.post(
          Uri.parse('$issuerBaseUrl/protocol/openid-connect/logout'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            if (accessToken != null) 'Authorization': 'Bearer $accessToken'
          },
          body: {
            'client_id': clientId,
            'client_secret': clientSecret,
            if (refreshToken != null) 'refresh_token': refreshToken,
          },
        );
        if (response.statusCode != 200) {
          debugPrint('Failed to revoke token: ${response.body}');
        }
      }
      // Use the provided `clearToken()` method
      await _tokenStorage.clearToken();
      return true;
    } catch (e) {
      debugPrint('Logout error: $e');
      return false;
    }
  }

  /// Exchanges the authorization code for tokens
  Future<bool> _exchangeCodeForToken(String code) async {
    final token = await _requestToken(
      grantType: 'authorization_code',
      additionalParams: {
        'code': code,
        'redirect_uri': '$redirectURL$callBackPath',
      },
    );

    if (token != null) {
      await _tokenStorage.saveToken(token);
      return true;
    }
    return false;
  }

  /// **Attempts to refresh the access token using a refresh token**
  Future<Tokens?> tryRefresh(String refreshToken) async {
    return await _requestToken(
      grantType: 'refresh_token',
      additionalParams: {
        'refresh_token': refreshToken,
      },
    );
  }

  Future<Tokens?> getStoredToken() async {
    return await _tokenStorage.getToken();
  }

  Future<void> saveToken(Tokens tokens) async {
    return await _tokenStorage.saveToken(tokens);
  }

  /// Handle token requests for (Token Exchange & Refresh)
  Future<Tokens?> _requestToken({
    required String grantType,
    required Map<String, String> additionalParams,
  }) async {
    final tokenEndpoint =
        Uri.parse('$issuerBaseUrl/protocol/openid-connect/token');

    final Map<String, String> body = {
      'client_id': clientId,
      'client_secret': clientSecret,
      'grant_type': grantType,
      ...additionalParams,
    };

    try {
      final response = await http.post(tokenEndpoint, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Tokens(
            accessToken: json['access_token'],
            refreshToken:
                json['refresh_token'] ?? additionalParams['refresh_token'],
            // Keep old refresh token if not provided
            expiresAt: json['expires_in'] ?? 0);
      } else {
        debugPrint('Token request failed: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception during token request: $e');
      return null;
    }
  }
}

final oidcDesktopServiceProvider = Provider<OidcDesktopService>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return OidcDesktopService(tokenStorage: tokenStorage);
});
