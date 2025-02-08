/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/tests/models/test_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_run.freezed.dart';
part 'test_run.g.dart';

@freezed
class TestRun with _$TestRun {
  factory TestRun({
    required TestCase testCase,
    required String conversationId,
    required DateTime startedAt,
  }) = _TestRun;

  const TestRun._();

  factory TestRun.fromJson(Map<String, dynamic> json) =>
      _$TestRunFromJson(json);
}
