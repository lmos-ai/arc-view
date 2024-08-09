import 'package:arc_view/src/chat/copy_to_clipboard_button.dart';
import 'package:arc_view/src/chat/models/chat_message.dart';
import 'package:arc_view/src/chat/rerun_message_button.dart';
import 'package:arc_view/src/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatMessageCard extends StatelessWidget {
  const ChatMessageCard({super.key, required this.chatMessage});

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          chatMessage.content.txt.padding().paddingBottom(24),
          Positioned(
            bottom: 0,
            right: 0,
            child: Row(
              children: [
                CopyToClipBoardButton(chatMessage.content),
                RerunMessageButton(chatMessage.content)
              ],
            ),
          ),
        ],
      ),
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
      child: Stack(
        children: [
          chatMessage.content
              .style(
                color: Theme.of(context).colorScheme.onPrimary,
              )
              .padding()
              .paddingBottom(24),
          Positioned(
            bottom: 0,
            right: 0,
            child: CopyToClipBoardButton(chatMessage.content),
          ),
        ],
      ),
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
