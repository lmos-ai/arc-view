/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/message/chat_message_card.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:arc_view/src/conversation/notifiers/conversation_notifier.dart';
import 'package:smiles/smiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref
        .watch(conversationNotifierProvider.select((c) => c.messages))
        .reversed
        .toList();

    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return switch (message.type) {
          MessageType.user => ChatMessageCard(chatMessage: message).toLeft(),
          MessageType.bot => BotChatMessageCard(message: message).toRight(),
          MessageType.loading => const LoadingChatMessageCard().toRight()
        };
      },
    );
  }
}
