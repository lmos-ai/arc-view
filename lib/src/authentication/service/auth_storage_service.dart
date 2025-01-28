import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _storage = FlutterSecureStorage();

  //Save token to storage
  static Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
    required int expiresAtMs,
  }) async {
    //[To-DO] it's causing error code = -34018 due to Add Keychain Sharing Capability
    // await Future.wait([
    //   _storage.write(key: 'access_token', value: accessToken),
    //   if (refreshToken != null)
    //     _storage.write(key: 'refresh_token', value: refreshToken),
    //   _storage.write(key: 'expires_at_ms', value: expiresAtMs.toString()),
    // ]);
  }

  //Read token from storage
  static Future<(String?, String?, int?)> readTokens() async {
    final results = await Future.wait([
      _storage.read(key: 'access_token'),
      _storage.read(key: 'refresh_token'),
      _storage.read(key: 'expires_at_ms'),
    ]);
    final accessToken = results[0];
    final refreshToken = results[1];
    final expiresStr = results[2];
    final expiresAtMs = (expiresStr != null) ? int.tryParse(expiresStr) : null;
    return (accessToken, refreshToken, expiresAtMs);
  }

  //clear the token
  static Future<void> clearTokens() async {
    await _storage.deleteAll();
  }
}
