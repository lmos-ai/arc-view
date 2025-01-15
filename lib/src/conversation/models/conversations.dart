/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversations.freezed.dart';

@Freezed(equal: false)
class Conversations with _$Conversations {
  factory Conversations({
    required List<Conversation> conversations,
    required Conversation current,
  }) = _Conversations;

  const Conversations._();

  Conversations addAsCurrent(Conversation conversation) {
    return copyWith(
        current: conversation, conversations: _addOrReplace(conversation));
  }

  Conversations update(Conversation conversation) {
    return copyWith(
        current: current.conversationId == conversation.conversationId
            ? conversation
            : current,
        conversations: _addOrReplace(conversation));
  }

  Conversations remove(Conversation conversation) {
    return copyWith(
        conversations: conversations
            .where((element) =>
                element.conversationId != conversation.conversationId)
            .toList());
  }

  List<Conversation> _addOrReplace(Conversation conversation) {
    List<Conversation> result = [];
    bool replaced = false;
    for (final c in conversations) {
      if (c.conversationId == conversation.conversationId) {
        replaced = true;
        result.add(conversation);
      } else {
        result.add(c);
      }
    }
    if (!replaced) {
      result.add(conversation);
    }
    return result;
  }
}
