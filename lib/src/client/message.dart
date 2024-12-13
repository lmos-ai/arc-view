/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

///
/// Message Type from the Arc API.
///
@freezed
class AgentResult with _$AgentResult {
  factory AgentResult({
    required List<Message> messages,
    required double responseTime,
  }) = _AgentResult;

  factory AgentResult.fromJson(Map<String, Object?> json) =>
      _$AgentResultFromJson(json);
}

@freezed
class Message with _$Message {
  factory Message({
    required String role,
    required String content,
  }) = _Message;

  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);
}
