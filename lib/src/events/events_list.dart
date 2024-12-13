/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/src/core/text.dart';
import 'package:arc_view/src/events/event_row_item.dart';
import 'package:arc_view/src/events/notifiers/agent_events_notifier.dart';
import 'package:arc_view/src/events/prompt_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EventsList extends ConsumerWidget {
  EventsList({super.key});

  final _handleEvents = [
    'AgentFinishedEvent',
    'LLMFinishedEvent',
    'LLMFunctionCalledEvent',
    'AgentLoadedEvent',
    'FunctionLoadedEvent',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(agentEventsNotifierProvider).where((e) {
      return _handleEvents.contains(e.type);
    }).toList();

    return events.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              'No events'.small,
              SmallLinkedText(
                'Click here for details',
                tip: 'Open Help page in a browser',
                onPressed: () {
                  launchUrlString(
                      'https://eclipse.dev/lmos/docs/arc/spring/graphql#event-subscriptions');
                },
              ),
            ],
          )
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
                  title: EventRowItem(event: event, json: json),
                  subtitle: [
                    SmallText(contextLabel),
                    Spacer(),
                    SmallText(json['duration'] != null
                        ? '${(json['duration'] as double?)?.toStringAsPrecision(3)} seconds'
                        : ''),
                  ].row(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          _transformEvent(event.type, context, json).toList(),
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
      _ => json['name'] ?? '',
    };
  }

  List<Widget> _transformEvent(String type, BuildContext context, json) {
    return switch (type) {
      'AgentFinishedEvent' => [
          SmallText('Name: ${json['agent']['name']}'),
          SmallText('FlowBreak: ${json['flowBreak']}'),
          SmallText('Tools: ${json['tools']}'),
        ],
      'AgentLoadedEvent' => [
          SmallText('ErrorMessage: ${json['errorMessage']}'),
        ],
      'FunctionLoadedEvent' => [
          SmallText('ErrorMessage: ${json['errorMessage']}'),
        ],
      'LLMFinishedEvent' => [
          SmallText('Model: ${json['model']}'),
          SmallText('TotalTokens: ${json['totalTokens']}'),
          SmallText('FunctionCallCount: ${json['functionCallCount']}'),
          [
            SmallText('System Prompt:'),
            SmallLinkedText('Click to open', tip: 'Open System prompt',
                onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => PromptView(json['messages'][0]['content']));
            })
          ].row(min: true),
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
