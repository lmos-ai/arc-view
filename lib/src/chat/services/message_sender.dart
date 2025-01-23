/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/notifiers/selected_usecase_notifier.dart';
import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/prompts/notifiers/current_prompt_notifier.dart';
import 'package:arc_view/src/prompts/notifiers/prompt_history_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_sender.g.dart';

@riverpod
MessageSender messageSender(Ref ref) => MessageSender(ref);

///
/// Sends a user message to the Agent and coordinates related
/// notifiers.
///
class MessageSender {
  MessageSender(this.ref);

  final Ref ref;

  sendUserMessage(String message) async {
    if (message.isEmpty) return;
    ref.read(currentPromptNotifierProvider.notifier).setPrompt(message);
    final selectedUseCase = ref.read(selectedUsecaseNotifierProvider);
    ref
        .read(conversationsNotifierProvider.notifier)
        .sendUserMessage(message, useCase: selectedUseCase);
    ref.read(promptHistoryNotifierProvider.notifier).add(message);
    ref.read(currentPromptNotifierProvider.notifier).clear();
  }
}
