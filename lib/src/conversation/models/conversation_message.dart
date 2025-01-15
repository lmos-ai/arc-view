/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_message.freezed.dart';

part 'conversation_message.g.dart';

enum MessageType { user, bot, loading }

@freezed
class ConversationMessage with _$ConversationMessage {
  factory ConversationMessage({
    required MessageType type,
    required String conversationId,
    required String content,
    double? responseTime,
    String? agent,
  }) = _ConversationMessage;

  factory ConversationMessage.fromJson(Map<String, Object?> json) =>
      _$ConversationMessageFromJson(json);
}

ConversationMessage loadingMessage(String conversationId) =>
    ConversationMessage(
      type: MessageType.loading,
      conversationId: conversationId,
      content: '...',
    );
