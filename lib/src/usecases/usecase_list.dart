/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/secondary_button.dart';
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
        'Use Cases'.txt.padByUnits(1, 1, 1, 2).toLeft(),
        ListView.builder(
          itemCount: useCases.cases.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: useCases.cases[index].name.small,
              subtitle: DateFormat.Hm()
                  .add_yMd()
                  .format(useCases.cases[index].createdAt)
                  .small,
              trailing: [
                SecondaryButton(
                    icon: Icons.delete,
                    description: 'Delete Use Case',
                    onPressed: () {
                      ref
                          .read(useCasesNotifierProvider.notifier)
                          .deleteUseCaseAt(index);
                    }),
              ].row(min: true),
              onTap: () {
                ref.read(useCasesNotifierProvider.notifier).setSelected(index);
              },
            );
          },
        ).expand(),
      ],
    );
  }
}
