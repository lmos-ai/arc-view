/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/message/copy_to_clipboard_button.dart';
import 'package:arc_view/src/chat/message/rerun_message_button.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smiles/smiles.dart';

class ChatMessageCard extends StatelessWidget {
  const ChatMessageCard({super.key, required this.chatMessage});

  final ConversationMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          chatMessage.content.txt.pad(16, 16, 32, 16),
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
    ).constrain(maxWidth: 600, minWidth: 100);
    ).size(maxWidth: 600, minWidth: 100);
  }
}

class BotChatMessageCard extends StatelessWidget {
  const BotChatMessageCard({super.key, required this.message});

  final ConversationMessage message;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Theme.of(context).colorScheme.primary,
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          //Wrap messages to container
          Container(
              width: double.infinity, // Full width
              padding: const EdgeInsets.all(8.0),
              child: MarkdownBody(
                data: message.content,
                styleSheet:
                    MarkdownStyleSheet.fromTheme(Theme.of(context).copyWith(
                  textTheme: Theme.of(context).textTheme.apply(
                        bodyColor: Colors.white,
                        // Set default text color to white
                        displayColor: Colors.white, // Headers will inherit this
                      ),
                )).copyWith(
                  code: TextStyle(
                      color: Colors.white,
                      fontFamily:
                          Theme.of(context).textTheme.bodyMedium?.fontFamily),
                  codeblockDecoration: BoxDecoration(
                    color: Colors.grey[700], // Background for code blocks
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[700]!, width: 1),
                  ),
                  codeblockPadding:
                      const EdgeInsets.all(8), // Padding inside code blocks
                ),
              )),
          Positioned(
            bottom: 0,
            right: 0,
            child: CopyToClipBoardButton(
              message.content,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    ).max(width: 600);
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
      ).padByUnits(2, 2, 2, 2),
    );
  }
}
