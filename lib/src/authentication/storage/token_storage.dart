/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import '../model/tokens.dart';

// ────────────────────────────────────────────
// Token Storage Factory Interface
// ────────────────────────────────────────────

abstract class TokenStorage {
  Future<void> saveToken(Tokens tokens) async {
    throw UnimplementedError("Token storage is not available.");
  }

  Future<Tokens?> getToken() async {
    return null;
  }

  Future<void> clearToken() async {}
}
