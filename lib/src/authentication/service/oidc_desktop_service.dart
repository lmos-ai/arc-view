import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'auth_storage_service.dart';
import '../util/auth_util.dart';

class OidcDesktopService {
  final String issuerBase;
  final String clientId;
  final String clientSecret;
  final String redirectBaseUrl;
  final List<String> scopes;
  final String callbackPath;

  OidcDesktopService({
    required this.issuerBase,
    required this.clientId,
    required this.clientSecret,
    required this.redirectBaseUrl,
    required this.scopes,
    required this.callbackPath,
  });


  // Initiates the login flow by spinning up a local server and opening the browser.
  Future<bool> login() async {
    final completer = Completer<bool>();

    //Get URI&PORT
    final uri = Uri.parse(redirectBaseUrl);
    final server = await HttpServer.bind(uri.host, uri.port);

    server.listen((HttpRequest request) async {
      if (request.uri.path == callbackPath) {
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
    final authUrl = Uri
        .parse('$issuerBase/protocol/openid-connect/auth')
        .replace(
      queryParameters: {
        'client_id': clientId,
        'redirect_uri': '$redirectBaseUrl$callbackPath',
        'response_type': 'code',
        'scope': scopes.join(' '),
        'state': generateRandomState(10),
      },
    );
    // Launch the browser
    await launchUrl(authUrl, mode: LaunchMode.externalApplication);
    return completer.future;
  }

  /// Exchanges the authorization code for tokens
  Future<bool> _exchangeCodeForToken(String code) async {
    final tokenEndpoint = Uri.parse(
        '$issuerBase/protocol/openid-connect/token');
    // Keycloak requires 'client_secret' if your client is confidential (TO-DO: Make it configurable)
    final response = await http.post(tokenEndpoint, body: {
      'grant_type': 'authorization_code',
      'client_id': clientId,
      'client_secret': clientSecret,
      'redirect_uri': '$redirectBaseUrl$callbackPath',
      'code': code,
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final newAccessToken = json['access_token'] as String?;
      final newRefreshToken = json['refresh_token'] as String?;
      final expiresIn = json['expires_in'] as int?;
      if (newAccessToken == null) return false;
      await AuthStorage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
          expiresAtMs: expiresIn ?? 0
      );
      return true;
    }
    return false;
  }
}
