/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_message.freezed.dart';
part 'conversation_message.g.dart';

enum MessageType { user, bot }

@freezed
class ConversationMessage with _$ConversationMessage {
  factory ConversationMessage({
    required MessageType type,
    required String conversationId,
    required String content,
    List<BinaryData>? binaryData,
    double? responseTime,
    String? agent,
  }) = _ConversationMessage;

  const ConversationMessage._();

  isBinary() => binaryData != null && binaryData!.isNotEmpty && content.isEmpty;

  factory ConversationMessage.fromJson(Map<String, Object?> json) =>
      _$ConversationMessageFromJson(json);
}

@freezed
class BinaryData with _$BinaryData {
  factory BinaryData({
    String? dataAsBase64,
    required String mimeType,
    String? source,
  }) = _BinaryData;

  factory BinaryData.fromJson(Map<String, Object?> json) =>
      _$BinaryDataFromJson(json);
}
