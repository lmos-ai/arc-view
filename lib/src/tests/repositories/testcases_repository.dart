/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/main.dart';
import 'package:arc_view/src/tests/models/test_case.dart';
import 'package:arc_view/src/tests/models/test_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'testcases_repository.g.dart';

@riverpod
TestCasesRepository testCasesRepository(Ref ref) {
  final preferences = ref.read(sharedPreferencesProvider);
  return TestCasesRepository(preferences);
}

///
/// Repository for loading and saving test cases.
///
class TestCasesRepository {
  TestCasesRepository(this._preferences);

  final SharedPreferences _preferences;

  List<TestCase> fetch() {
    final useCases = _preferences.getStringList('testcases')?.map((e) {
      return TestCase.fromJson(jsonDecode(e));
    }).toList();
    return useCases ?? List.empty();
  }

  save(TestCases testCases) {
    _preferences.setStringList(
      'testcases',
      testCases.testCases.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}
