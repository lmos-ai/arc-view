/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/buttons/send_message_button.dart';
import 'package:arc_view/src/chat/chat_field.dart';
import 'package:arc_view/src/chat/chat_list.dart';
import 'package:arc_view/src/chat/notifiers/selected_usecase_notifier.dart';
import 'package:arc_view/src/chat/toolbar/chat_tool_bar.dart';
import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/prompts/notifiers/current_prompt_notifier.dart';
import 'package:arc_view/src/prompts/notifiers/prompt_history_notifier.dart';
import 'package:arc_view/src/prompts/prompt_list.dart';
import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smiles/smiles.dart';

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
    final selectedUseCaseName = ref.read(selectedUsecaseNotifierProvider);
    final useCases = await ref.read(useCasesNotifierProvider.future);
    final selectedUseCase = useCases.cases
        .firstWhere((useCase) => useCase.name == selectedUseCaseName);
    ref
        .read(conversationsNotifierProvider.notifier)
        .addUserMessage(message, useCase: selectedUseCase);
    ref.read(promptHistoryNotifierProvider.notifier).add(message);
    ref.read(currentPromptNotifierProvider.notifier).clear();
  }
}
