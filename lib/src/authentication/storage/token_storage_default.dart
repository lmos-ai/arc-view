/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:arc_view/src/authentication/model/tokens.dart';
import 'package:arc_view/src/authentication/storage/token_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config_loader.dart';
import '../util/auth_util.dart';

// ────────────────────────────────────────────
// Secure Storage Implementation (Flutter Secure Storage)
// ────────────────────────────────────────────
class SecureTokenStorage implements TokenStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<void> saveToken(Tokens tokens) async {
    try {
      await _storage.write(key: 'access_token', value: tokens.accessToken);
      await _storage.write(key: 'refresh_token', value: tokens.refreshToken);
      await _storage.write(
          key: 'expires_at', value: tokens.expiresAt?.toString());
    } catch (e) {
      throw Exception('Failed to save token: $e');
    }
  }

  @override
  Future<Tokens?> getToken() async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      final refreshToken = await _storage.read(key: 'refresh_token');
      final expiresAtString = await _storage.read(key: 'expires_at');

      if (accessToken == null || refreshToken == null) return null;

      final expiresAt =
          expiresAtString != null ? int.tryParse(expiresAtString) ?? 0 : 0;

      return Tokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresAt: expiresAt,
      );
    } catch (e) {
      throw Exception('Failed to retrieve token: $e');
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      await _storage.delete(key: 'access_token');
      await _storage.delete(key: 'refresh_token');
      await _storage.delete(key: 'expires_at');
    } catch (e) {
      throw Exception('Failed to clear token: $e');
    }
  }
}

// ────────────────────────────────────────────
// Riverpod StateNotifier Storage Implementation (In-Memory)
// ────────────────────────────────────────────
class RiverpodTokenStorage extends StateNotifier<Tokens?>
    implements TokenStorage {
  RiverpodTokenStorage() : super(null);

  @override
  Future<void> saveToken(Tokens tokens) async {
    state = tokens;
  }

  @override
  Future<Tokens?> getToken() async {
    return state;
  }

  @override
  Future<void> clearToken() async {
    state = null;
  }
}

// ────────────────────────────────────────────
// Riverpod Token Storage Provider (default)
// ────────────────────────────────────────────

// final tokenStorageProvider = Provider<TokenStorage>((ref) {
//   final storageType = Config.get('storage.type', defaultValue: "default");
//   if (storageType == 'secure') {
//     return SecureTokenStorage();
//   } else {
//     return RiverpodTokenStorage();
//   }
// });

// ────────────────────────────────────────────
// Riverpod Notifier for Reactive Token Management
// ────────────────────────────────────────────
final tokenNotifierProvider = AsyncNotifierProvider<TokenNotifier, Tokens?>(
  () => TokenNotifier(),
);

class TokenNotifier extends AsyncNotifier<Tokens?> {
  late final TokenStorage _storage;

  TokenNotifier() {
    final storageType = Config.get('storage.type', defaultValue: "default");
    _storage = storageType == 'secure'
        ? SecureTokenStorage()
        : RiverpodTokenStorage();
  }

  @override
  Future<Tokens?> build() async {
    return await _storage.getToken();
  }

  Future<void>  saveToken (Tokens tokens) async {
    state = const AsyncValue.loading();
    await _storage.saveToken(tokens);
    state = AsyncValue.data(tokens);
  }

  Future<void> clearToken() async {
    state = const AsyncValue.loading();
    await _storage.clearToken();
    state = const AsyncValue.data(null);
  }

  Future<Tokens?> getToken() async {
    return await _storage.getToken();
  }

  bool get hasValidToken {
    final tokens = state.asData?.value; // This is the underlying Tokens? object
    if (tokens == null) return false;
    return isTokenExpired(tokens.expiresAt);
  }
}
