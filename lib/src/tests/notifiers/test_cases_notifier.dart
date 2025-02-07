/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/notifiers/selected_usecase_notifier.dart';
import 'package:arc_view/src/chat/right_panel.dart';
import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/tests/models/test_case.dart';
import 'package:arc_view/src/tests/models/test_cases.dart';
import 'package:arc_view/src/tests/repositories/testcases_repository.dart';
import 'package:arc_view/src/tools/models/test_tool.dart';
import 'package:arc_view/src/tools/notifiers/selected_tool_notifier.dart';
import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_cases_notifier.g.dart';

///
/// Manages the test cases.
///
@Riverpod(keepAlive: true)
class TestCasesNotifier extends _$TestCasesNotifier {
  @override
  TestCases build() {
    final cases = ref.read(testCasesRepositoryProvider).fetch();
    return TestCases(testCases: cases, runs: List.empty());
  }

  storeConversationAsTest(String name, Conversation conversation) {
    if (conversation.messages.isEmpty) return;
    state = state.copyWith(testCases: [
      ...state.testCases,
      TestCase(
        name: name.isEmpty ? 'Test ${state.testCases.length + 1}' : name,
        createdAt: DateTime.now(),
        expected: ref.currentConversation(),
      ),
    ]);
    ref.read(testCasesRepositoryProvider).save(state);
  }

  runTestCase(
    TestCase testCase, {
    UseCase? useCase,
    Set<TestTool>? tools,
  }) async {
    final cid = 'test-cid-${DateTime.now().millisecondsSinceEpoch}';
    state = state.addTestRun(testCase, cid);
    await ref.read(conversationsNotifierProvider.notifier).replay(
          replay: testCase.expected,
          conversationId: cid,
          useCase: useCase,
        );
  }

  deleteTestCase(TestCase testCase) {
    state = state.copyWith(
      testCases: state.testCases.where((e) => e != testCase).toList(),
    );
    ref.read(testCasesRepositoryProvider).save(state);
  }

  void addTestCases(TestCases testCases) {
    state = state.copyWith(
      testCases: [...state.testCases, ...testCases.testCases],
      runs: [...state.runs, ...testCases.runs],
    );
    ref.read(testCasesRepositoryProvider).save(state);
  }
}

extension TestCasesNotifierExtension on WidgetRef {
  runTestCaseWithUseCases(TestCase testCase) {
    final useCases = read(selectedUsecaseNotifierProvider);
    final selectedTools = read(selectedToolNotifierProvider);
    read(testCasesNotifierProvider.notifier).runTestCase(
      testCase,
      useCase: useCases,
      tools: selectedTools,
    );
  }

  deleteTestCase(TestCase testCase) {
    read(testCasesNotifierProvider.notifier).deleteTestCase(testCase);
  }

  storeConversationAsTest(String name, {Conversation? conversation}) {
    read(testCasesNotifierProvider.notifier).storeConversationAsTest(
      name,
      conversation ?? read(conversationsNotifierProvider).current,
    );
    read(rightPanelNavProvider.notifier).state = 2; // TODO
  }
}
