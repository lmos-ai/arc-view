/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/message/bot_chat_message_card.dart';
import 'package:arc_view/src/chat/message/chat_message_card.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversation =
        ref.watch(conversationsNotifierProvider.select((c) => c.current));
    final messages = conversation.messages.map((message) {
      return switch (message.type) {
        MessageType.user => ChatMessageCard(chatMessage: message).toLeft(),
        MessageType.bot => BotChatMessageCard(message: message).toRight(),
      };
    }).toList();

    if (conversation.loading == true) {
      messages.add(LoadingChatMessageCard().toRight());
    }

    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) => messages[(messages.length - 1) - index],
    );
  }
}
