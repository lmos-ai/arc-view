/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/dialogs/apply_usecase_dialog.dart';
import 'package:arc_view/src/chat/notifiers/selected_usecase_notifier.dart';
import 'package:arc_view/src/client/notifiers/agents_notifier.dart';
import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/conversation/services/conversation_exporter.dart';
import 'package:arc_view/src/conversation/services/conversation_importer.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/tests/tests_tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smiles/smiles.dart';

class ChatToolBar extends ConsumerWidget {
  const ChatToolBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (_agentAvailable(ref) != true) {
      return const SizedBox();
    }

    final currentConversation =
        ref.watch(conversationsNotifierProvider.select((e) => e.current));
    final selectedUsecase = ref.watch(selectedUsecaseNotifierProvider);

    return [
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: [
          SecondaryButton(
            description: 'Apply Use Cases',
            onPressed: () {
              showDialog(
                  context: context, builder: (_) => ApplyUsecaseDialog());
            },
            icon: Icons.import_contacts,
          ),
          if (selectedUsecase != null) ...[
            selectedUsecase.name.small.padByUnits(0, 2, 0, 0),
            SecondaryButton(
              description: 'Remove Use Case',
              icon: Icons.close,
              onPressed: () {
                ref.read(selectedUsecaseNotifierProvider.notifier).remove();
              },
            )
          ],
        ].row(),
      ),
      Spacer(),
      TestsToolBar(),
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SecondaryButton(
              description: 'Replay conversation',
              enabled: currentConversation.messages.isNotEmpty,
              onPressed: () {
                final selectedUseCase =
                    ref.read(selectedUsecaseNotifierProvider);
                ref
                    .read(conversationsNotifierProvider.notifier)
                    .replay(useCase: selectedUseCase);
              },
              icon: Icons.replay_circle_filled_sharp,
            ),
            SecondaryButton(
              description: 'Import Conversation',
              onPressed: () {
                ref.read(conversationImporterProvider).load();
              },
              icon: Icons.upload,
            ),
            SecondaryButton(
              description: 'Export Conversation',
              onPressed: () {
                ref.read(conversationExporterProvider).export();
              },
              icon: Icons.download,
            ),
            SecondaryButton(
              description: 'Show Settings',
              onPressed: () {
                context.push("/settings");
              },
              icon: Icons.settings,
            ),
          ],
        ),
      )
    ].row();
  }

  _agentAvailable(WidgetRef ref) {
    final agents = ref.watch(agentsNotifierProvider);
    return agents.hasValue && agents.value?.names.isNotEmpty == true;
  }
}
