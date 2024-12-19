/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class UseCaseList extends ConsumerWidget {
  const UseCaseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useCases = ref.watch(useCasesNotifierProvider).valueOrNull;
    if (useCases == null) {
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
              trailing: useCases.selected == index
                  ? Icon(
                      Icons.check,
                      size: 14,
                      color: context.colorScheme.primary,
                    )
                  : null,
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
