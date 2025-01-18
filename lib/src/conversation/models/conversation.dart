/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/models/system_context.dart';
import 'package:arc_view/src/client/models/user_context.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  factory Conversation({
    required List<ConversationMessage> messages,
    required UserContext userContext,
    required SystemContext systemContext,
    required String conversationId,
    required DateTime createdAt,
    bool? loading,
  }) = _Conversation;

  const Conversation._();

  Conversation add(List<ConversationMessage> newMessages) {
    return copyWith(messages: [...messages, ...newMessages]);
  }

  Conversation addUserMessage(
    String content, {
    bool? loading,
    bool? streamAudio,
  }) {
    return copyWith(
      loading: loading,
      messages: [
        ...messages,
        ConversationMessage(
          type: MessageType.user,
          conversationId: conversationId,
          content: content,
          binaryData: streamAudio == true
              ? [BinaryData(data: 'STREAM_SOURCE', mimeType: 'audio/pcm')]
              : null,
        ),
      ],
    );
  }

  Conversation addSystem(List<SystemContextEntry> systemEntries) {
    if (systemEntries.isEmpty) return this;
    final keys = systemEntries.map((e) => e.key).toSet();
    return copyWith(
      systemContext: systemContext.copyWith(
        entries: [
          ...systemContext.entries.where((e) => !keys.contains(e.key)),
          ...systemEntries
        ],
      ),
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
