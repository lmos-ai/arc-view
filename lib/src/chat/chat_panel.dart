/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/audio/record_button.dart';
import 'package:arc_view/src/chat/buttons/new_conversation_button.dart';
import 'package:arc_view/src/chat/buttons/send_message_button.dart';
import 'package:arc_view/src/chat/buttons/show_previous_prompts_button.dart';
import 'package:arc_view/src/chat/chat_field.dart';
import 'package:arc_view/src/chat/chat_list.dart';
import 'package:arc_view/src/chat/services/message_sender.dart';
import 'package:arc_view/src/chat/toolbar/chat_tool_bar.dart';
import 'package:arc_view/src/features/notifiers/features_notifier.dart';
import 'package:arc_view/src/prompts/notifiers/current_prompt_notifier.dart';
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
    return Consumer(
      builder: (context, ref, child) {
        final features = ref.watch(featuresNotifierProvider);
        return Column(
          children: [
            const ChatToolBar(),
            const ChatList().expand(),
            [
              Card(
                elevation: 6,
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Row(
                  children: [
                    NewConversationButton(),
                    PreviousPromptButton(),
                    _chatField(ref),
                    SendMessageButton(onPressed: () => _send(ref)),
                  ],
                ).padding(),
              ).expand(),
              if (features.isNotEmpty) const HGap.small(),
              if (features.isNotEmpty)
                Card(child: const RecordButton().padding())
            ].row(min: true),
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

  _send(WidgetRef ref) {
    ref.read(messageSenderProvider).sendUserMessage(_textController.text);
  }
}
