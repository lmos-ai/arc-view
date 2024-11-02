/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/src/core/text.dart';
import 'package:arc_view/src/events/milestone_event.dart';
import 'package:arc_view/src/events/models/agent_events.dart';
import 'package:arc_view/src/events/notifiers/agent_events_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

import '../conversation/services/conversation_colors.dart';

class EventsList extends ConsumerWidget {
  EventsList({super.key});

  final _handleEvents = [
    'AgentFinishedEvent',
    'LLMFinishedEvent',
    'LLMFunctionCalledEvent',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(agentEventsNotifierProvider).where((e) {
      return _handleEvents.contains(e.type);
    }).toList();

    return events.isEmpty
        ? 'No events'.small.center()
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final json = jsonDecode(event.payload) as Map<String, dynamic>;
              final contextLabel = _getEventLabel(json);

              return Card(
                elevation: 0,
                child: ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  subtitle: [
                    SmallText(contextLabel),
                    Spacer(),
                    SmallText(
                        '${(json['duration'] as double?)?.toStringAsPrecision(3)} seconds'),
                  ].row(),
                  title: _indent(event.type)
                      ? event.type.txt
                      : MilestoneEvent(
                          color: _getColor(event, context),
                          name: event.type,
                        ),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _transformEvent(event.type, json).toList(),
                    ),
                  ],
                ),
              );
            },
          );
  }

  String _getEventLabel(Map<String, dynamic> json) {
    return switch (json['context']) {
      {'filter': String label} => label,
      {'agent': String label} => label,
      _ => '',
    };
  }

  Color _getColor(AgentEvent event, BuildContext context) {
    return switch (event.type) {
      'AgentFinishedEvent' => color(event.conversationId ?? 'unknown'),
      _ => context.colorScheme.tertiary,
    };
  }

  bool _indent(String type) {
    return switch (type) {
      'AgentFinishedEvent' => false,
      _ => true,
    };
  }

  List<Widget> _transformEvent(String type, json) {
    return switch (type) {
      'AgentFinishedEvent' => [
          SmallText('Name: ${json['agent']['name']}'),
          SmallText('FlowBreak: ${json['flowBreak']}'),
        ],
      'LLMFinishedEvent' => [
          SmallText('Model: ${json['model']}'),
          SmallText('TotalTokens: ${json['totalTokens']}'),
          SmallText('FunctionCallCount: ${json['functionCallCount']}'),
          SmallText('Content: ${_tryGetContent(json)}'),
        ],
      'LLMFunctionCalledEvent' => [
          SmallText('Name: ${json['name']}'),
          SmallText('Params: ${json['param']}'),
          SmallText('Result: ${_tryGetValue(json)}')
        ],
      _ => [SmallText(json.toString())],
    };
  }

  _tryGetContent(json) {
    try {
      return json['result']['value']['content'];
    } catch (e) {
      return '';
    }
  }

  _tryGetValue(json) {
    try {
      return json['result']['value'];
    } catch (e) {
      return '';
    }
  }
}
