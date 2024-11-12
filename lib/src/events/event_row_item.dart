/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/conversation/services/conversation_colors.dart';
import 'package:arc_view/src/events/action_event.dart';
import 'package:arc_view/src/events/milestone_event.dart';
import 'package:arc_view/src/events/models/agent_events.dart';
import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';

class EventRowItem extends StatelessWidget {
  const EventRowItem({
    super.key,
    required this.event,
    required this.json,
  });

  final AgentEvent event;
  final Map<String, dynamic> json;

  @override
  Widget build(BuildContext context) {
    return _titleWidget(event, context, json);
  }

  Color _getColor(AgentEvent event, BuildContext context) {
    return switch (event.type) {
      'AgentFinishedEvent' => color(event.conversationId ?? 'unknown'),
      _ => context.colorScheme.tertiary,
    };
  }

  Widget _titleWidget(
      AgentEvent event, BuildContext context, Map<String, dynamic> json) {
    return switch (event.type) {
      'AgentFinishedEvent' =>
        MilestoneEvent(color: _getColor(event, context), name: event.type),
      'AgentLoadedEvent' => ActionEvent(
          name: event.type,
          success: json['errorMessage'] == null,
        ),
      'FunctionLoadedEvent' => ActionEvent(
          name: event.type,
          success: json['errorMessage'] == null,
        ),
      _ => event.type.txt,
    };
  }
}
