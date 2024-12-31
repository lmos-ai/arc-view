/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/prompts/notifiers/current_prompt_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class NewConversationButton extends ConsumerWidget {
  const NewConversationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(Icons.add, color: context.colorScheme.onSurface),
      onPressed: () {
        ref.read(conversationsNotifierProvider.notifier).newConversation();
        ref.read(currentPromptNotifierProvider.notifier).clear();
      },
    ).tip('New Conversation');
  }
}
