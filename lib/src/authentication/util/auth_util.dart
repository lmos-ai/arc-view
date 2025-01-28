import 'dart:math';

import 'package:flutter_appauth/flutter_appauth.dart';
import '../model/token.dart';
import '../oidc_config.dart';

final FlutterAppAuth _appAuth = FlutterAppAuth();

bool isTokenExpired(int? expiresAtMs) {
  if (expiresAtMs == null) return true;
  final nowMs = DateTime.now().millisecondsSinceEpoch;
  // You might leave a small buffer, e.g., 30 seconds, to avoid edge cases
  return nowMs >= (expiresAtMs - 30 * 1000);
}

// Try refreshing the token if refreshToken is available
Future<TokenResult?> tryRefresh(String refreshToken) async {
  try {
    final tokenResponse = await _appAuth.token(
      TokenRequest(
        clientId,
        '$redirectBaseUrl$callbackPath',
        clientSecret: clientSecret,
        issuer: issuerBase,
        refreshToken: refreshToken,
        scopes: scopes,
      ),
    );
    if (tokenResponse != null && tokenResponse.accessToken != null) {
      final access = tokenResponse.accessToken!;
      final refresh = tokenResponse.refreshToken ?? refreshToken;
      final expiresAt =
          tokenResponse.accessTokenExpirationDateTime?.millisecondsSinceEpoch ??
              0;
      return TokenResult(
          accessToken: access, refreshToken: refresh, expiresAtMs: expiresAt);
    }
  } catch (e) {
    // Log or handle refresh error
    return null;
  }
  return null;
}

String generateRandomState(int length) {
  const characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random.secure();
  final randomState = List.generate(
      length, (index) => characters[random.nextInt(characters.length)]).join();
  return randomState;
}
