/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/src/tests/models/test_cases.dart';
import 'package:arc_view/src/tests/notifiers/test_cases_notifier.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'testcases_importer.g.dart';

@riverpod
TestCasesImporter testCasesImporter(Ref ref) {
  return TestCasesImporter(ref.watch(testCasesNotifierProvider.notifier));
}

class TestCasesImporter {
  TestCasesImporter(this.testCasesNotifier);

  final TestCasesNotifier testCasesNotifier;

  load() async {
    const XTypeGroup typeGroup = XTypeGroup(extensions: <String>['json']);
    final file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (file == null) return;
    final json = await file.readAsString();
    final testCases = TestCases.fromJson(jsonDecode(json));
    testCasesNotifier.addTestCases(testCases);
  }
}
