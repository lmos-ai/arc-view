/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:arc_view/src/events/models/agent_events.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_export.freezed.dart';
part 'conversation_export.g.dart';

@freezed
class ConversationExport with _$ConversationExport {
  factory ConversationExport({
    required Conversation conversation,
    required List<AgentEvent> events,
  }) = _ConversationExport;

  factory ConversationExport.fromJson(Map<String, dynamic> json) =>
      _$ConversationExportFromJson(json);
}
