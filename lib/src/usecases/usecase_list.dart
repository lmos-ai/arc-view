/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/core/section_title.dart';
import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smiles/smiles.dart';

class UseCaseList extends ConsumerWidget {
  const UseCaseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useCases = ref.watch(useCasesNotifierProvider).valueOrNull;
    if (useCases == null || useCases.cases.isEmpty) {
      return ''.txt.pad(4, 8, 4, 8);
    }
    return Column(
      children: [
        SectionTitle(text: 'Use Cases').padByUnits(1, 1, 1, 0).toLeft(),
        ListView.builder(
          itemCount: useCases.cases.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: useCases.selectedCase == useCases.cases[index]
                    ? context.colorScheme.primary.withValues(alpha: 0.3)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: useCases.cases[index].name.small,
                subtitle: DateFormat.Hm()
                    .add_yMd()
                    .format(useCases.cases[index].createdAt)
                    .small,
                trailing: SecondaryButton(
                    icon: Icons.delete,
                    confirming: true,
                    description: 'Delete Use Case',
                    onPressed: () {
                      ref
                          .read(useCasesNotifierProvider.notifier)
                          .deleteUseCaseAt(index);
                    }),
                onTap: () {
                  ref
                      .read(useCasesNotifierProvider.notifier)
                      .setSelected(index);
                },
              ),
            );
          },
        ).expand(),
      ],
    );
  }
}
