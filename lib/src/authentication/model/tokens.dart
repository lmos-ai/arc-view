/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

class Tokens {
  final String? accessToken;
  final String? refreshToken;
  final int? expiresAt;

  Tokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });
}
