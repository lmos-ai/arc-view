/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/notifiers/agents_notifier.dart';
import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:arc_view/src/conversation/notifiers/conversation_history_notifier.dart';
import 'package:arc_view/src/conversation/notifiers/conversation_notifier.dart';
import 'package:arc_view/src/conversation/services/conversation_colors.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatToolBar extends ConsumerWidget {
  const ChatToolBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(conversationHistoryNotifierProvider);
    final currentConversation = ref.watch(conversationNotifierProvider);

    if (_agentAvailable(ref) != true) {
      return const SizedBox();
    }

    List<Conversation> all = [];
    if (history.isNotEmpty) {
      final all = [...history, currentConversation];
      all.sort((a, b) => a.conversationId.compareTo(b.conversationId));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (final conversation in all)
          SecondaryButton(
            description: 'Show conversation ${conversation.conversationId}',
            onPressed: () {
              ref
                  .watch(conversationNotifierProvider.notifier)
                  .updateConversation(conversation);
            },
            icon: Icons.bookmark_border,
            color: color(conversation.conversationId),
          ),
        SecondaryButton(
          description: 'Replay conversation',
          onPressed: () {
            ref.read(conversationNotifierProvider.notifier).reply();
          },
          icon: Icons.replay_circle_filled_sharp,
        ),
      ],
    );
  }

  _agentAvailable(WidgetRef ref) {
    final agents = ref.watch(agentsNotifierProvider);
    return agents.hasValue && agents.value?.names.isNotEmpty == true;
  }
}
