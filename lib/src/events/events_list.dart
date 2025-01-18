/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/src/core/text.dart';
import 'package:arc_view/src/events/event_filter_panel.dart';
import 'package:arc_view/src/events/event_row_item.dart';
import 'package:arc_view/src/events/models/agent_events.dart';
import 'package:arc_view/src/events/notifiers/agent_events_notifier.dart';
import 'package:arc_view/src/events/prompt_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';
import 'package:url_launcher/url_launcher_string.dart';

// State provider to manage the drawer state
final filterDrawerProvider = StateProvider<bool>((ref) => false);

// State provider to manage available filters
final availableFiltersProvider = StateProvider<Map<String, List<String>>>(
    (ref) => {'EventType': [], 'Conversation': [], 'AgentName': []});

//State Provider for filter group
final eventTypeFilterProvider = StateProvider<List<String>>((ref) => []);
final conversationFilterProvider = StateProvider<List<String>>((ref) => []);
final agentNameFilterProvider = StateProvider<List<String>>((ref) => []);

class EventsList extends ConsumerWidget {
  const EventsList({super.key});

  static final handleEvents = [
    'AgentFinishedEvent',
    'LLMFinishedEvent',
    'LLMFunctionCalledEvent',
    'AgentLoadedEvent',
    'FunctionLoadedEvent',
    'UseCaseEvent',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFilterDrawerOpen = ref.watch(filterDrawerProvider);
    final List<AgentEvent> events =
        ref.watch(agentEventsNotifierProvider.select((events) {
      return events.where((e) {
        return handleEvents.contains(e.type) && applyFiltersAndSorting(e, ref);
      }).toList();
    }));

    // Schedule the filter update after the widget tree has been built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateFilterProvider(ref);
    });

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        if (!isFilterDrawerOpen)
          Positioned.fill(
              child: events.isEmpty
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
                  : Column(children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            final event = events[index];
                            final json = jsonDecode(event.payload)
                                as Map<String, dynamic>;
                            final contextLabel = _getEventLabel(json);

                            return Card(
                              elevation: 0,
                              child: ExpansionTile(
                                expandedAlignment: Alignment.topLeft,
                                childrenPadding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _transformEvent(
                                            event.type, context, json)
                                        .toList(),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ])),
        if (isFilterDrawerOpen)
          Positioned.fill(
            child: EventFilterPanel().animate().moveX(begin: -350),
          ),
      ],
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
      'UseCaseEvent' => [
          SmallText('Name: ${json['name']}'),
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

  static bool applyFiltersAndSorting(AgentEvent e, WidgetRef ref) {
    final selectedEventTypes = ref.watch(eventTypeFilterProvider);
    final selectedConversations = ref.watch(conversationFilterProvider);
    final selectedAgents = ref.watch(agentNameFilterProvider);
    bool matchesEventType =
        selectedEventTypes.isEmpty || selectedEventTypes.contains(e.type);
    bool matchesConversations = selectedConversations.isEmpty ||
        selectedConversations.contains(e.conversationId);

    //Agent is the part of payload to decode it
    var agentName = json.decode(e.payload)['agent']?['name'] ?? '';
    bool matchesAgentName =
        selectedAgents.isEmpty || selectedAgents.contains(agentName);
    //To-DO Sorting

    return matchesEventType && matchesConversations && matchesAgentName;
  }

  //Dynamically Update Filter Group Values
  _updateFilterProvider(WidgetRef ref) {
    //Get All Supported Events
    final events = ref
        .watch(agentEventsNotifierProvider.select((list) => list.where((e) {
              return handleEvents.contains(e.type);
            })))
        .toList();

    // Extract unique values for each filter type
    final eventTypes = events.map((e) => e.type).toSet().toList();
    // Extract Conversations
    final conversationNames =
        events.map((e) => e.conversationId!!).toSet().toList();
    //Extract Agent Name from payload
    final List<String> agentNames = events
        .map((e) {
          // Decode the JSON payload and extract the agent name
          var agentName = json.decode(e.payload)['agent']?['name'];
          return agentName?.toString() ??
              ''; // Return the name, which may be null
        })
        .where((name) => name.isNotEmpty) // Remove null values, if any
        .toSet() // Ensure uniqueness
        .toList();

    // Update available filters (Dynamically Calculate)
    ref.read(availableFiltersProvider.notifier).state = {
      'EventType': eventTypes,
      'Conversation': conversationNames,
      'AgentName': agentNames,
    };
  }
}
