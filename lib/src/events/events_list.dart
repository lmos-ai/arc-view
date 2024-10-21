/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/src/core/text.dart';
import 'package:arc_view/src/events/notifiers/agent_events_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

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
        ? const Center(child: SmallText('No events'))
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final json = jsonDecode(event.payload);

              return Card(
                elevation: 0,
                child: ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  subtitle: SmallText(
                      '${(json['duration'] as double?)?.toStringAsPrecision(3)} seconds'),
                  title: _indent(event.type)
                      ? event.type.txt
                      : DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: _getColor(event.type, context),
                                width: 4,
                              ),
                            ),
                          ),
                          child: event.type.txt.pad(0, 0, 0, 16),
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

  Color _getColor(String type, BuildContext context) {
    return switch (type) {
      'AgentFinishedEvent' => context.colorScheme.primary,
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
