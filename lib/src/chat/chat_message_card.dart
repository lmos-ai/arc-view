import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:arc_view/src/chat/models/chat_message.dart';
import 'package:arc_view/src/core/extensions.dart';

class ChatMessageCard extends StatelessWidget {
  const ChatMessageCard({super.key, required this.chatMessage});

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(8),
      child: chatMessage.content.txt.padding(),
    ).max(maxWidth: 600);
  }
}

class BotChatMessageCard extends StatelessWidget {
  const BotChatMessageCard({super.key, required this.chatMessage});

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Theme.of(context).colorScheme.primary,
      margin: const EdgeInsets.all(8),
      child: chatMessage.content
          .style(
            color: Theme.of(context).colorScheme.onPrimary,
          )
          .padding(),
    ).max(maxWidth: 600);
  }
}

class LoadingChatMessageCard extends StatelessWidget {
  const LoadingChatMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Theme.of(context).colorScheme.primary,
      margin: const EdgeInsets.all(8),
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.white,
        size: 20,
      ).padding(16),
    );
  }
}
