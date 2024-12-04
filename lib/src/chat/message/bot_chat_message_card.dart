/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:arc_view/src/chat/message/copy_to_clipboard_button.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:arc_view/src/conversation/services/conversation_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:smiles/smiles.dart';

class BotChatMessageCard extends StatelessWidget {
  const BotChatMessageCard({super.key, required this.message});

  final ConversationMessage message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color(message.conversationId),
                shape: BoxShape.circle,
              ),
            ),
          ),
          MarkdownBody(
            fitContent: true,
            data: message.content,
            styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
              code:
                  TextStyle(fontFamily: theme.textTheme.bodyMedium?.fontFamily),
              codeblockDecoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withOpacity(0.2),
                // Background for code blocks
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[700]!, width: 1),
              ),
              codeblockPadding: const EdgeInsets.all(8),
            ),
          ).padByUnits(3, 2, 6, 2),
          Positioned(
            bottom: 0,
            right: 0,
            child: CopyToClipBoardButton(message.content),
          ),
          if (message.responseTime != null)
            Positioned(
              bottom: 0,
              left: 0,
              child: '${message.responseTime} sec'.small.pad(8, 16, 8, 16),
            ),
        ],
      ),
    ).max(width: 600);
  }
}
