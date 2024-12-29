/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:arc_view/src/chat/message/copy_to_clipboard_button.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:arc_view/src/conversation/services/conversation_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:smiles/smiles.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:markdown/markdown.dart' as md;

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
            selectable: true,
            fitContent: true,
            data: message.content,
            onTapLink: (text, href, title) {
              if (href != null) launchUrlString(href);
            },
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
            builders: {
              'code': MarkDownCodeBuilder(),
            },
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

//MarkDown-Code Builder
class MarkDownCodeBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final codeContent = element.textContent;
    if (codeContent.isEmpty) return null;

    final lines = codeContent.split('\n');
    final hasMultipleLines = lines.length > 2;

    // Use ValueNotifier to track copy state
    final ValueNotifier<bool> isCopiedNotifier = ValueNotifier<bool>(false);

    return Builder(
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          // Space around the code block
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasMultipleLines)
                Align(
                  alignment: Alignment.topRight,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isCopiedNotifier,
                    builder: (context, isCopied, child) {
                      return GestureDetector(
                        onTap: () {
                          if (isCopied) {
                            // Reset to copy state
                            isCopiedNotifier.value = false;
                          } else {
                            // Set to copied state
                            Clipboard.setData(ClipboardData(text: codeContent));
                            isCopiedNotifier.value = true;
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isCopied ? Icons.check : Icons.copy,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              isCopied ? 'Copied' : 'Copy',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 8), // Space between the button and code
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scroll
                child: SelectableText(
                  codeContent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
