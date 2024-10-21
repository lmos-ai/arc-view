/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/chat_field.dart';
import 'package:arc_view/src/chat/chat_list.dart';
import 'package:arc_view/src/conversation/notifiers/conversation_notifier.dart';
import 'package:smiles/smiles.dart';
import 'package:arc_view/src/prompts/notifiers/prompt_history_notifier.dart';
import 'package:arc_view/src/prompts/prompt_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPanel extends StatefulWidget {
  const ChatPanel({super.key});

  @override
  State<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> {
  late TextEditingController _textController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer(
      builder: (context, ref, child) {
        return Column(
          children: [
            const ChatList().expand(),
            Card(
              elevation: 6,
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _chatField(ref),
                  _previousPromptButton(ref, theme),
                  _deleteButton(ref, theme),
                  _sendButton(ref),
                ],
              ).padding(),
            ),
          ],
        );
      },
    );
  }

  _chatField(WidgetRef ref) => Expanded(
        child: Consumer(builder: (ctx, ref, child) {
          _textController.text = ref.watch(currentPromptNotifierProvider);
          return ChatField(
            controller: _textController,
            onSubmitted: (_) => _send(ref),
          ).padding();
        }),
      );

  _previousPromptButton(WidgetRef ref, ThemeData theme) => IconButton(
      icon: Icon(
        Icons.line_weight_sharp,
        color: theme.colorScheme.onSurface,
      ),
      onPressed: () {
        //ref.read(currentPromptControllerProvider.notifier).rotate();
        showPromptList(context);
      });

  _sendButton(WidgetRef ref) => 'Send'.onButtonPressed(() => _send(ref));

  _send(WidgetRef ref) {
    if (_textController.text.isEmpty) return;
    ref
        .read(conversationNotifierProvider.notifier)
        .addUserMessage(_textController.text);
    ref.read(promptHistoryNotifierProvider.notifier).add(_textController.text);
    ref.read(currentPromptNotifierProvider.notifier).clear();
    _textController.text = '';
  }

  _deleteButton(WidgetRef ref, ThemeData theme) => IconButton(
        icon: Icon(
          Icons.delete_sweep,
          color: theme.colorScheme.onSurface,
        ),
        onPressed: () {
          ref.read(conversationNotifierProvider.notifier).clear();
          ref.read(currentPromptNotifierProvider.notifier).clear();
        },
      );
}
