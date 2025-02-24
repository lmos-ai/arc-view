/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/tests/new_test_case_button.dart';
import 'package:arc_view/src/tests/notifiers/test_cases_notifier.dart';
import 'package:arc_view/src/tests/test_status_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class TestsToolBar extends ConsumerWidget {
  const TestsToolBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversation =
        ref.watch(conversationsNotifierProvider.select((c) => c.current));
    final runningTest = ref.read(testCasesNotifierProvider
        .select((t) => t.getTestRun(conversation.conversationId)));

    return [
      if (runningTest != null)
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: [
            HGap.small(),
            TestStatusLabel(testName: runningTest.testCase.name),
            SecondaryButton(
              description: 'Run Test',
              icon: Icons.play_circle,
              onPressed: () {
                ref.runTestCaseWithUseCases(runningTest.testCase);
              },
            )
          ].row(),
        ),
      HGap(),
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: [
          Icon(
            Icons.science,
            size: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ).padByUnits(0, 0, 0, 1),
          NewTestCaseButton(),
        ].row(),
      )
    ].row(min: true);
  }
}
