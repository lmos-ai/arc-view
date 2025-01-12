/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/notifiers/selected_usecase_notifier.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smiles/smiles.dart';

class ApplyUsecaseDialog extends ConsumerWidget {
  const ApplyUsecaseDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: [
        'Apply Use Cases'.txt,
        Spacer(),
        SecondaryButton(
          icon: Icons.close,
          description: 'Close Dialog',
          onPressed: () {
            context.pop();
          },
        )
      ].row(),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          'Send custom use cases to Agents (The Agent must support the feature).'
              .txt
              .padByUnits(0, 0, 1, 0),
          Divider(),
          _buildList(context, ref)?.expand() ??
              'No use cases defined'.small.padByUnits(4, 0, 0, 0),
        ],
      ).size(height: 300, width: 400),
    );
  }

  Widget? _buildList(BuildContext context, WidgetRef ref) {
    final useCases = ref.watch(useCasesNotifierProvider).valueOrNull;
    if (useCases == null || useCases.cases.isEmpty) {
      return null;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          itemCount: useCases.cases.length,
          itemBuilder: (context, index) {
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.circle_outlined, size: 12),
              title: useCases.cases[index].name.txt,
              subtitle: DateFormat.Hm()
                  .add_yMd()
                  .format(useCases.cases[index].createdAt)
                  .small,
              onTap: () {
                ref
                    .read(selectedUsecaseNotifierProvider.notifier)
                    .setSelected(useCases.cases[index]);
                context.pop();
              },
            );
          },
        ).expand(),
      ],
    );
  }
}
