/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import '../../client/http/http_client.dart';
import '../model/openid_config.dart';
import '../util/auth_util.dart';

class OidcHttpClient {
  final HttpRestClient _httpClient;
  final OpenIdCredentialConfig _config;

  OidcHttpClient({
    required OpenIdCredentialConfig config,
  })  : _httpClient = HttpRestClient(baseUrl: config.issuerBaseUrl),
        _config = config;

  /// Handles token requests (e.g., token exchange, refresh token).
  Future<Map<String, dynamic>?> requestToken({
    required String grantType,
    required Map<String, String> additionalParams,
  }) async {
    final Map<String, String> body = {
      'client_id': _config.clientId,
      'client_secret': _config.clientSecret,
      'grant_type': grantType,
      ...additionalParams,
    };

    try {
      final response = await _httpClient.post(
        'protocol/openid-connect/token',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Token request failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Exception during token request: $e');
    }
  }

  /// Handles token revocation (logout).
  Future<void> revokeToken({
    required String? tokenToRevoke,
    required String? accessToken,
  }) async {
    if (tokenToRevoke == null) return;

    final Map<String, String> body = {
      'client_id': _config.clientId,
      'client_secret': _config.clientSecret,
      'token': tokenToRevoke,
    };

    try {
      final response = await _httpClient.post(
        'protocol/openid-connect/logout',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          if (accessToken != null) 'Authorization': 'Bearer $accessToken',
        },
        body: body,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to revoke token: ${response.body}');
      }
    } catch (e) {
      throw Exception('Exception during token revocation: $e');
    }
  }

  Uri buildAuthUrl(){
    return Uri.parse('${_config.issuerBaseUrl}/protocol/openid-connect/auth')
        .replace(
      queryParameters: {
        'client_id': _config.clientId,
        'redirect_uri': '${_config.redirectURL}${_config.callBackPath}',
        'response_type': 'code',
        'scope': _config.scopes.join(' '),
        'state': generateRandomState(10),
      },
    );
  }
}
