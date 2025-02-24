/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';
import 'dart:typed_data';

import 'package:arc_view/src/tests/models/test_cases.dart';
import 'package:arc_view/src/tests/notifiers/test_cases_notifier.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'testcases_exporter.g.dart';
 
@riverpod
TestCasesExporter testCasesExporter(Ref ref) {
  return TestCasesExporter(ref.watch(testCasesNotifierProvider));
}

class TestCasesExporter {
  TestCasesExporter(this.testCases);

  final TestCases testCases;

  export() async {
    const String fileName = 'testCases.json';
    final result = await getSaveLocation(suggestedName: fileName);
    if (result == null) return;
    final Uint8List fileData = utf8.encode(
      jsonEncode(testCases.copyWith(runs: List.empty()).toJson()),
    );
    final XFile textFile = XFile.fromData(
      fileData,
      mimeType: 'application/json',
      name: fileName,
    );
    await textFile.saveTo(result.path);
  }
}
