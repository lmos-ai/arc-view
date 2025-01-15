/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent_events.freezed.dart';
part 'agent_events.g.dart';

@freezed
class AgentEvent with _$AgentEvent {
  factory AgentEvent({
    required String type,
    required String payload,
    String? conversationId,
  }) = _AgentEvent;

  factory AgentEvent.fromJson(Map<String, dynamic> json) =>
      _$AgentEventFromJson(json);
}
