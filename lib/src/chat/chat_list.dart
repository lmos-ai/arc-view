/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/message/bot_chat_message_card.dart';
import 'package:arc_view/src/chat/message/chat_message_card.dart';
import 'package:arc_view/src/chat/message/expected_chat_message_card.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/tests/notifiers/test_cases_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversation =
        ref.watch(conversationsNotifierProvider.select((c) => c.current));
    final runningTest = ref.read(testCasesNotifierProvider
        .select((t) => t.getTestRun(conversation.conversationId)));
    final messageCards = [];

    for (final (i, message) in conversation.messages.indexed) {
      final expected =
          runningTest?.testCase.expected.messages.elementAtOrNull(i);
      messageCards.add(_convertMessageToCard(message, expected));
    }

    if (conversation.loading == true) {
      messageCards.add(LoadingChatMessageCard().toRight());
    }

    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      itemCount: messageCards.length,
      itemBuilder: (context, i) => messageCards[(messageCards.length - 1) - i],
    );
  }

  _convertMessageToCard(
    ConversationMessage message,
    ConversationMessage? expected,
  ) {
    return switch (message.type) {
      MessageType.user => ChatMessageCard(chatMessage: message).toLeft(),
      MessageType.bot => expected != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ExpectedChatMessageCard(
                  message: expected,
                  success: message.content == expected.content,
                ).expand(),
                BotChatMessageCard(message: message).expand(),
              ],
            )
          : BotChatMessageCard(message: message).toRight(),
    };
  }
}
