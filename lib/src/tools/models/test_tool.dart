/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_tool.freezed.dart';
part 'test_tool.g.dart';

@freezed
class TestTool with _$TestTool {
  factory TestTool({
    required String name,
    required String title,
    required String id,
    required String description,
    required String value,
  }) = _TestTool;

  TestTool._();

  factory TestTool.fromJson(Map<String, dynamic> json) =>
      _$TestToolFromJson(json);
}
