import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arc_view/src/chat/chat_message_card.dart';
import 'package:arc_view/src/chat/controllers/chat_controller.dart';
import 'package:arc_view/src/chat/models/chat_message.dart';
import 'package:arc_view/src/core/extensions.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref
        .watch(chatControllerProvider.select((c) => c.messages))
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
          MessageType.bot => BotChatMessageCard(chatMessage: message).toRight(),
          MessageType.loading => const LoadingChatMessageCard().toRight()
        };
      },
    );
  }
}
