/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/tests/notifiers/test_cases_notifier.dart';
import 'package:arc_view/src/tests/services/testcases_exporter.dart';
import 'package:arc_view/src/tests/services/testcases_importer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smiles/smiles.dart';

///
/// Panel for displaying test cases.
///
class TestCasesPanel extends ConsumerWidget {
  const TestCasesPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tests =
        ref.watch(testCasesNotifierProvider.select((e) => e.testCases));

    return Card(
      margin: const EdgeInsets.all(0),
      child: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(children: [
              SecondaryButton(
                description: 'Import Test Cases',
                icon: Icons.upload,
                onPressed: () {
                  ref.read(testCasesImporterProvider).load();
                },
              ),
            ]),
            SecondaryButton(
              description: 'Download Test Cases',
              onPressed: () {
                ref.read(testCasesExporterProvider).export();
              },
              icon: Icons.download,
            ),
          ],
        ),
        (tests.isEmpty)
            ? const Center(child: Text('No tests yet')).expand()
            : ListView.builder(
                itemCount: tests.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: SecondaryButton(
                      description: 'Play test',
                      icon: Icons.play_arrow,
                      onPressed: () {
                        ref.runTestCaseWithUseCases(tests[index]);
                      },
                    ),
                    title: tests[index].name.txt,
                    subtitle:
                        DateFormat.Hm().format(tests[index].createdAt).small,
                    trailing: SecondaryButton(
                      description: 'Delete test',
                      icon: Icons.delete,
                      onPressed: () {
                        ref.deleteTestCase(tests[index]);
                      },
                    ),
                  );
                }).expand()
      ].column(),
    );
  }
}
