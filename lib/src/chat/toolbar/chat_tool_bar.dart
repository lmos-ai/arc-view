/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/notifiers/agents_notifier.dart';
import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/conversation/services/conversation_exporter.dart';
import 'package:arc_view/src/conversation/services/conversation_importer.dart';
import 'package:arc_view/src/core/secondary_button.dart';
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

    return [
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SecondaryButton(
              description: 'Replay conversation',
              onPressed: () {
                ref.read(conversationsNotifierProvider.notifier).replay();
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
    ].row(min: true).toRight();
  }

  _agentAvailable(WidgetRef ref) {
    final agents = ref.watch(agentsNotifierProvider);
    return agents.hasValue && agents.value?.names.isNotEmpty == true;
  }
}
