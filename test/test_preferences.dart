/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:shared_preferences/shared_preferences.dart';

class TestPreferences implements SharedPreferences {
  final Map<String, dynamic> _map = {};

  @override
  Future<bool> clear() async {
    return true;
  }

  @override
  Future<bool> commit() async {
    return true;
  }

  @override
  bool containsKey(String key) {
    return _map.containsKey(key);
  }

  @override
  Object? get(String key) {
    return _map[key];
  }

  @override
  bool? getBool(String key) {
    return _map[key];
  }

  @override
  double? getDouble(String key) {
    return _map[key];
  }

  @override
  int? getInt(String key) {
    return _map[key];
  }

  @override
  Set<String> getKeys() {
    return _map.keys.toSet();
  }

  @override
  String? getString(String key) {
    return _map[key];
  }

  @override
  List<String>? getStringList(String key) {
    return _map[key];
  }

  @override
  Future<void> reload() async {}

  @override
  Future<bool> remove(String key) async {
    _map.remove(key);
    return true;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    _map[key] = value;
    return true;
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    _map[key] = value;
    return true;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _map[key] = value;
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _map[key] = value;
    return true;
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    _map[key] = value;
    return true;
  }
}
