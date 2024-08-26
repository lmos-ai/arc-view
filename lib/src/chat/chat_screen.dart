/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/address_bar.dart';
import 'package:arc_view/src/chat/chat_field.dart';
import 'package:arc_view/src/chat/chat_list.dart';
import 'package:arc_view/src/chat/toolbar/tool_bar.dart';
import 'package:arc_view/src/prompts/prompt_history_notifier.dart';
import 'package:arc_view/src/prompts/prompt_list.dart';
import 'package:arc_view/src/conversation/conversation_notifier.dart';
import 'package:arc_view/src/core/extensions.dart';
import 'package:arc_view/src/layout/adaptive_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
    return AdaptiveScaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final theme = Theme.of(context);
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AddressBar(),
                const ToolBar(),
                Expanded(
                  child: const Align(
                    alignment: Alignment.topCenter,
                    child: ChatList(),
                  ).max(width: 800),
                ),
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
                ).max(width: 800),
              ],
            ),
          );
        },
      ),
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
        color: theme.primaryColor,
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
          color: theme.primaryColor,
        ),
        onPressed: () {
          ref.read(conversationNotifierProvider.notifier).clear();
          ref.read(currentPromptNotifierProvider.notifier).clear();
        },
      );
}
