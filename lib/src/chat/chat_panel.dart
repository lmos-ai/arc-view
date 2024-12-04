/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/buttons/record_button.dart';
import 'package:arc_view/src/chat/chat_field.dart';
import 'package:arc_view/src/chat/chat_list.dart';
import 'package:arc_view/src/chat/toolbar/chat_tool_bar.dart';
import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/prompts/notifiers/prompt_history_notifier.dart';
import 'package:arc_view/src/prompts/prompt_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

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
            const ChatToolBar(),
            const ChatList().expand(),
            Card(
              elevation: 6,
              margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Row(
                children: [
                  _newConversationButton(ref, theme),
                  _previousPromptButton(ref, theme),
                  _chatField(ref),
                  _sendButton(ref),
                ],
              ).padding(),
            ),
          ],
        );
      },
    );
  }

  _chatField(WidgetRef ref) =>
      Expanded(
        child: Consumer(builder: (ctx, ref, child) {
          _textController.text = ref.watch(currentPromptNotifierProvider);
          return ChatField(
            controller: _textController,
            onSubmitted: (_) => _send(ref),
          ).padding();
        }),
      );

  _previousPromptButton(WidgetRef ref, ThemeData theme) =>
      IconButton(
          icon: Icon(
            Icons.line_weight_sharp,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () {
            //ref.read(currentPromptControllerProvider.notifier).rotate();
            showPromptList(context);
          }).tip('Show previous prompts');

  _sendButton(WidgetRef ref) => RecordButton(onPressed: () => _send(ref));

  _send(WidgetRef ref) {
    if (_textController.text.isEmpty) return;
    ref
        .read(conversationsNotifierProvider.notifier)
        .addUserMessage(_textController.text);
    ref.read(promptHistoryNotifierProvider.notifier).add(_textController.text);
    ref.read(currentPromptNotifierProvider.notifier).clear();
    _textController.text = '';
  }

  _newConversationButton(WidgetRef ref, ThemeData theme) =>
      IconButton(
        icon: Icon(
          Icons.add,
          color: theme.colorScheme.onSurface,
        ),
        onPressed: () {
          ref.read(conversationsNotifierProvider.notifier).newConversation();
          ref.read(currentPromptNotifierProvider.notifier).clear();
        },
      ).tip('New Conversation');
}
