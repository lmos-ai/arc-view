/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UsecaseOverviewPanel extends ConsumerWidget {
  const UsecaseOverviewPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UseCase? selectedCase =
        ref.watch(useCasesNotifierProvider).valueOrNull?.selectedCase;
    if (selectedCase == null) return ''.txt;

    final sections = selectedCase.splitContent();
    final sectionKeys = sections.map((s) => GlobalKey()).toList();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: ListView.builder(
            itemCount: sections.length,
            itemBuilder: (context, i) => ListTile(
              title: sections[i].$1.txt,
              onTap: () {
                Scrollable.ensureVisible(sectionKeys[i].currentContext!);
              },
            ),
          ).size(width: 300),
        ).padByUnits(0, 1, 2, 2),
        SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < sections.length; i++)
                Card(
                  key: sectionKeys[i],
                  margin: const EdgeInsets.all(8),
                  child: MarkdownBody(
                    data: sections[i].$2,
                    onTapLink: (text, href, title) {
                      if (href != null) launchUrlString(href);
                    },
                  ).padByUnits(2, 2, 2, 2),
                )
            ],
          ),
        ).expand()
      ],
    );
  }
}
