/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:http/http.dart' as http;

class HttpRestClient {
  final String baseUrl;

  HttpRestClient({required this.baseUrl});

  /// Sends a POST request to the specified endpoint.
  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpoint');

    return await http.post(
      uri,
      headers: headers,
      body: body,
    );
  }
}
