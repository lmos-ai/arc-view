/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/conversation/services/conversation_colors.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class ConversationsPanel extends ConsumerWidget {
  const ConversationsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversations =
        ref.watch(conversationsNotifierProvider.select((e) => e.conversations));
    return Card(
      margin: const EdgeInsets.all(0),
      child: (conversations.isEmpty)
          ? const Center(child: Text('No conversations yet'))
          : [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(
                    description: 'Delete all conversations',
                    onPressed: () {
                      ref
                          .read(conversationsNotifierProvider.notifier)
                          .deleteAll();
                    },
                    icon: Icons.delete_sweep_rounded,
                  ),
                ],
              ),
              ListView.builder(
                  itemCount: conversations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        ref
                            .watch(conversationsNotifierProvider.notifier)
                            .updateConversation(conversations[index]);
                      },
                      trailing: SecondaryButton(
                        description: 'Delete conversation',
                        icon: Icons.delete,
                        onPressed: () {
                          ref
                              .read(conversationsNotifierProvider.notifier)
                              .delete(conversations[index]);
                        },
                      ),
                      leading: Icon(
                        Icons.chat,
                        size: 16,
                        color: color(conversations[index].conversationId),
                      ),
                      title: (conversations[index]
                                  .messages
                                  .elementAtOrNull(0)
                                  ?.content
                                  .truncate(20) ??
                              'empty')
                          .txt,
                      subtitle:
                          '${conversations[index].messages.length} messages - ${conversations[index].conversationId}'
                              .small,
                    );
                  }).expand()
            ].column(),
    );
  }
}

extension on String {
  String truncate(int maxLength) {
    if (maxLength >= length) {
      return this;
    }
    return replaceRange(maxLength, length, '...');
  }
}
