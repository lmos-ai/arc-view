/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_history_notifier.g.dart';

@riverpod
class ConversationHistoryNotifier extends _$ConversationHistoryNotifier {
  final _log = Logger('ConversationHistoryNotifier');

  @override
  List<Conversation> build() {
    _log.finer('Building conversation history');
    return List.empty();
  }

  add(Conversation conversation) {
    if (state.contains(conversation)) return;
    if (conversation.messages.isEmpty) return;
    _log.fine('Adding conversation to history: $conversation');

    state = [...state, conversation];
  }

  void clear() {
    state = List.empty();
  }

  remove(Conversation conversation) {
    state = state
        .where(
            (element) => element.conversationId != conversation.conversationId)
        .toList();
  }
}
