/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class Config {
  static late Map<String, dynamic> _config;

  /// Loads the configuration file from assets.
  static Future<void> loadConfig() async {
    try {
      final yamlString =
          await rootBundle.loadString('assets/config/app-config.yaml');

      // Replace placeholders with environment variables
      final replacedYamlString = yamlString
          .replaceAll('\${ARC_VIEW_ISSUER_BASE_URL}',
              Platform.environment['ARC_VIEW_ISSUER_BASE_URL'] ?? '')
          .replaceAll('\${ARC_VIEW_OIDC_CLIENT_ID}',
              Platform.environment['ARC_VIEW_OIDC_CLIENT_ID'] ?? '')
          .replaceAll('\${ARC_VIEW_OIDC_CLIENT_SECRET}',
              Platform.environment['ARC_VIEW_OIDC_CLIENT_SECRET'] ?? '')
          .replaceAll('\${ARC_VIEW_REDIRECT_BASE_URL}',
              Platform.environment['ARC_VIEW_REDIRECT_BASE_URL'] ?? '');
      _config = jsonDecode(jsonEncode(loadYaml(replacedYamlString)));
    } catch (e) {
      _config = {}; // Fallback to an empty map in case of error
    }
  }

  ///Retrieves a configuration value by key, returning an optional default.
  static dynamic get(String key, {dynamic defaultValue}) {
    List<String> keys = key.split('.');
    dynamic value = _config;

    for (String k in keys) {
      if (value is Map<String, dynamic> && value.containsKey(k)) {
        value = value[k];
      } else {
        return defaultValue;
      }
    }

    return value;
  }

  /// Retrieves the complete configuration map.
  static Map<String, dynamic> getAll() {
    return _config;
  }
}
