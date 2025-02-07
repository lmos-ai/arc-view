/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/notifiers/selected_usecase_notifier.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/core/text_input_dialog.dart';
import 'package:arc_view/src/tools/notifiers/selected_tool_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditMessageButton extends ConsumerWidget {
  const EditMessageButton(this._message, {this.color, super.key});

  final ConversationMessage _message;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(
        Icons.edit,
        size: 12,
        color: color,
        semanticLabel: 'Edit Message and replay conversation.',
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => TextInputDialog(
            title: 'Edit Message',
            value: _message.content,
            actionText: 'Update Conversation',
            onConfirm: (newName) {
              final selectedUseCase = ref.read(selectedUsecaseNotifierProvider);
              final selectedTools = ref.read(selectedToolNotifierProvider);
              ref.read(conversationsNotifierProvider.notifier).updateAndReplay(
                    _message,
                    _message.copyWith(content: newName),
                    useCase: selectedUseCase,
                    tools: selectedTools,
                  );
            },
          ),
        );
      },
    );
  }
}
