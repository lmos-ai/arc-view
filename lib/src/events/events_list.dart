/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/src/core/text.dart';
import 'package:arc_view/src/events/event_row_item.dart';
import 'package:arc_view/src/events/models/agent_events.dart';
import 'package:arc_view/src/events/notifiers/agent_events_notifier.dart';
import 'package:arc_view/src/events/prompt_view.dart';
import 'package:arc_view/src/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';
import 'package:url_launcher/url_launcher_string.dart';

// State provider to manage the drawer state
final filterDrawerProvider = StateProvider<bool>((ref) => false);

// State provider to manage selected filters
final selectedFiltersProvider = StateProvider<Map<String, List<String>>>(
    (ref) => {'EventType': [], 'ModelName': [], 'AgentName': []});

// Provider for sorting state (ASC or DESC)
final selectedSortProvider = StateProvider<String>((ref) => 'DESC');

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
    // Watch the state providers
    final isFilterDrawerOpen = ref.watch(filterDrawerProvider);

    final events = ref.watch(agentEventsNotifierProvider).where((e) {
      return _handleEvents.contains(e.type);
    }).toList();

    // Schedule the filter update after the widget tree has been built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateFilterProvider(ref, events);
    });

    return Stack(children: [
      events.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                'No events'.small,
                SmallLinkedText(
                  'Click here for details',
                  tip: 'Open Help page in a browser',
                  onPressed: () {
                    launchUrlString(
                        'https://lmos-ai.github.io/arc/docs/spring/graphql#event-subscriptions');
                  },
                ),
              ],
            )
          : Column(children: [
              _buildFilterAnsSortSection(ref),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    final json =
                        jsonDecode(event.payload) as Map<String, dynamic>;
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _transformEvent(event.type, context, json)
                                .toList(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ]),
      // Custom Filter Drawer
      if (isFilterDrawerOpen) _buildFilterDrawer(context, ref)
    ]);
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

  //Create Filter & Sort section placeholder
  _buildFilterAnsSortSection(WidgetRef ref) {
    final currentSort = ref.watch(selectedSortProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Filter Button
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              ref.read(filterDrawerProvider.notifier).state =
                  !ref.watch(filterDrawerProvider);
            },
          ),
          // Sort Button
          IconButton(
            icon: Icon(currentSort == 'DESC'
                ? Icons.arrow_circle_down
                : Icons.arrow_circle_up),
            onPressed: () {
              // Toggle between ASC and DESC
              ref.read(selectedSortProvider.notifier).state =
                  currentSort == 'ASC' ? 'DESC' : 'ASC';
            },
            tooltip: 'Sort: $currentSort',
          )
        ],
      ),
    );
  }

  //Create Custom Filter Drawer
  _buildFilterDrawer(BuildContext context, WidgetRef ref) {
    final selectedFilters = ref.watch(selectedFiltersProvider);
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 300, // Adjust the width of the drawer
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            // Drawer Header with Close Icon
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back the Drawer
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      ref.read(filterDrawerProvider.notifier).state = false;
                    },
                  ),
                  Text(
                    'Filters',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Clear all filters
                      ref.read(selectedFiltersProvider.notifier).state = {
                        'EventType': [],
                        'ModelName': [],
                        'AgentName': [],
                      };
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                    ),
                    child: Icon(Icons.filter_alt_off),
                  ),
                ],
              ),
            ),
            // Filter Types and their Values
            Expanded(
              child: ListView(
                children: selectedFilters.entries.map((entry) {
                  final filterType = entry.key;
                  final options = entry.value;

                  return ExpansionTile(
                    title: Text(filterType,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: options.map((option) {
                      final isSelected =
                          selectedFilters[filterType]?.contains(option) ??
                              false;

                      return CheckboxListTile(
                        title: Text(option),
                        value: isSelected,
                        onChanged: (bool? value) {
                          // Update selected filters
                          final updatedFilters = {...selectedFilters};
                          final selectedValues = List<String>.from(
                              updatedFilters[filterType] ?? []);

                          if (value == true) {
                            selectedValues.add(option); // Add selected value
                          } else {
                            selectedValues
                                .remove(option); // Remove unselected value
                          }

                          updatedFilters[filterType] = selectedValues;
                          ref.read(selectedFiltersProvider.notifier).state =
                              updatedFilters;
                        },
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
            // Action Buttons: Apply and Clear Filters
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ref.read(filterDrawerProvider.notifier).state =
                          false; // Close the drawer
                      // Apply filters (implement filter logic as needed)
                      print(
                          'Filters applied: ${ref.read(selectedFiltersProvider)}');
                    },
                    child: Text('Apply Filters'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _updateFilterProvider(WidgetRef ref, List<AgentEvent> events) {
    //Get the unique event types from the filtered events
     final eventTypes = events.map((e) => e.type).toSet().toList();
     // Update the selected filters with the new EventType values
     ref.read(selectedFiltersProvider.notifier).state = {
       'EventType': eventTypes,
       'ModelName': [],  // Reset ModelName filter (or you can dynamically update it as well)
       'AgentName': [],  // Reset AgentName filter (or dynamically update it as needed)
     };
  }
}
