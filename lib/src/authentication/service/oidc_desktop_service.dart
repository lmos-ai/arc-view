/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:async';
import 'dart:io';

import 'package:arc_view/src/authentication/model/tokens.dart';
import 'package:arc_view/src/authentication/storage/token_storage_default.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

import '../client/oidc_api.dart';
import '../model/openid_config.dart';

class OidcDesktopService {
  final TokenNotifier _tokenNotifier;
  final OpenIdCredentialConfig _config;
  final OidcHttpClient _oidcHttpClient;
  final Logger _logger = Logger("OidcDesktopService");

  OidcDesktopService(
      {required TokenNotifier tokenNotifier,
      required OpenIdCredentialConfig config,
      required OidcHttpClient oidcHttpClient})
      : _tokenNotifier = tokenNotifier,
        _config = config,
        _oidcHttpClient = oidcHttpClient;

  // Initiates the login flow by spinning up a local server and opening the browser.
  Future<bool> login() async {
    final completer = Completer<bool>();
    try {
      final uri = Uri.parse(_config.redirectURL);
      final server = await HttpServer.bind(uri.host, uri.port);

      //Spinning the local server
      server.listen((HttpRequest request) async {
        if (request.uri.path == _config.callBackPath) {
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

      // Launch the browser
      await launchUrl(_oidcHttpClient.buildAuthUrl(),
          mode: LaunchMode.externalApplication);
      return completer.future;
    } catch (e) {
      _logger.log(Level.SEVERE, 'Login error: $e');
      completer.complete(false);
    }
    return completer.future;
  }

  // Initiates the logout flow
  Future<bool> logout() async {
    bool logoutSuccess = false;
    try {
      final tokens = await _tokenNotifier.getToken();
      final refreshToken = tokens?.refreshToken;
      final accessToken = tokens?.accessToken;

      // Revoke token from the auth server (Optional, but recommended)
      await _oidcHttpClient.revokeToken(
        tokenToRevoke: refreshToken ?? accessToken,
        accessToken: accessToken,
      );
      logoutSuccess = true;
    } catch (e) {
      _logger.log(Level.SEVERE, 'Logout error: $e');
    } finally {
      await _tokenNotifier.clearToken();
    }
    return logoutSuccess;
  }

  /// **Attempts to refresh the access token using a refresh token**
  Future<Tokens?> tryRefresh(String refreshToken) async {
    Tokens? refreshTokens;
    try {
      final response = await _oidcHttpClient.requestToken(
        grantType: 'refresh_token',
        additionalParams: {
          'refresh_token': refreshToken,
        },
      );
      if (response != null) {
        refreshTokens = _parseTokens(response);
      }
    } catch (e) {
      _logger.log(Level.SEVERE, 'Token refresh error: $e');
    }
    return refreshTokens;
  }

  Future<Tokens?> getStoredToken() async {
    return await _tokenNotifier.getToken();
  }

  Future<void> saveToken(Tokens tokens) async {
    return await _tokenNotifier.saveToken(tokens);
  }

  /// Exchanges the authorization code for tokens
  Future<bool> _exchangeCodeForToken(String code) async {
    bool exchangeSuccess = false;
    try {
      final response = await _oidcHttpClient.requestToken(
        grantType: 'authorization_code',
        additionalParams: {
          'code': code,
          'redirect_uri': '${_config.redirectURL}${_config.callBackPath}',
        },
      );

      if (response != null) {
        final tokens = _parseTokens(response);
        await _tokenNotifier.saveToken(tokens);
        exchangeSuccess = true;
      }
    } catch (e) {
      _logger.log(Level.SEVERE, 'Token exchange error: $e');
    }
    return exchangeSuccess;
  }

  Tokens _parseTokens(Map<String, dynamic> response) {
    return Tokens(
      accessToken: response['access_token'],
      refreshToken: response['refresh_token'],
      expiresAt: response['expires_in'] ?? 0,
    );
  }
}

final oidcDesktopServiceProvider = Provider<OidcDesktopService>((ref) {
  final tokenState = ref.watch(tokenNotifierProvider.notifier);
  final openIdConfig = OpenIdCredentialConfigFactory.fromAppConfig();
  final oidcHttpclient = OidcHttpClient(config: openIdConfig);
  return OidcDesktopService(
      tokenNotifier: tokenState,
      config: openIdConfig,
      oidcHttpClient: oidcHttpclient);
});
