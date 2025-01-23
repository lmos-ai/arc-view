/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/tests/models/test_case.dart';
import 'package:arc_view/src/tests/models/test_run.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_cases.freezed.dart';
part 'test_cases.g.dart';

@freezed
class TestCases with _$TestCases {
  factory TestCases({
    required List<TestCase> testCases,
    required List<TestRun> runs,
  }) = _TestCases;

  const TestCases._();

  TestRun? getTestRun(String conversationId) {
    for (final run in runs) {
      if (run.conversationId == conversationId) {
        return run;
      }
    }
    return null;
  }

  TestCases addTestRun(TestCase testCase, String conversationId) {
    return copyWith(runs: [
      ...runs,
      TestRun(
        testCase: testCase,
        conversationId: conversationId,
        startedAt: DateTime.now(),
      ),
    ]);
  }

  factory TestCases.fromJson(Map<String, dynamic> json) =>
      _$TestCasesFromJson(json);
}
