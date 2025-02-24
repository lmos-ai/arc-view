/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/main.dart';
import 'package:arc_view/src/tools/models/test_tool.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'tools_repository.g.dart';

@riverpod
ToolsRepository toolsRepository(Ref ref) {
  final preferences = ref.read(sharedPreferencesProvider);
  return ToolsRepository(preferences);
}

///
/// Repository for loading and saving usecases.
///
class ToolsRepository {
  ToolsRepository(this._preferences);

  final SharedPreferences _preferences;

  List<TestTool> fetch() {
    final tools = _preferences.getStringList('testTools')?.map((e) {
      return TestTool.fromJson(jsonDecode(e));
    }).toList();
    return tools ?? List.empty();
  }

  save(List<TestTool> tools) {
    _preferences.setStringList(
      'testTools',
      tools.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}
