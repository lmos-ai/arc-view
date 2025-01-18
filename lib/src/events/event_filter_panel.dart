/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/events/events_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

///
/// Panel for configuring the filtering of events.
///
class EventFilterPanel extends ConsumerWidget {
  const EventFilterPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SecondaryButton(
              icon: Icons.arrow_back,
              color: Colors.white,
              description: 'Close Filters',
              onPressed: () {
                ref.read(filterDrawerProvider.notifier).state = false;
              },
            ),
            'Filters'.txt,
            SecondaryButton(
              description: 'Clear filters',
              onPressed: () {
                // Clear all selected filters
                ref.read(eventTypeFilterProvider.notifier).state = [];
                ref.read(conversationFilterProvider.notifier).state = [];
                ref.read(agentNameFilterProvider.notifier).state = [];
              },
              icon: Icons.filter_alt_off,
            ),
          ],
        ),
        // Filter List
        Expanded(
          child: ListView(
            children: ref.watch(availableFiltersProvider).entries.map((entry) {
              final filterType = entry.key;
              final options = entry.value;
              final selectedValues = ref.watch(
                filterType == 'EventType'
                    ? eventTypeFilterProvider
                    : filterType == 'Conversation'
                        ? conversationFilterProvider
                        : agentNameFilterProvider,
              );
              return _buildFilterGroup(
                  filterType, selectedValues, options, ref);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterGroup(String filterType, List<String> selectedValues,
      List<String> options, WidgetRef ref) {
    return ExpansionTile(
      title: Text(
        filterType,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      children: options.map((option) {
        final isSelected = selectedValues.contains(option);

        return CheckboxListTile(
          title: Text(option),
          value: isSelected,
          onChanged: (bool? value) {
            final updatedValues = List<String>.from(selectedValues);
            if (value == true) {
              updatedValues.add(option);
            } else {
              updatedValues.remove(option);
            }

            switch (filterType) {
              case 'EventType':
                ref.read(eventTypeFilterProvider.notifier).state =
                    updatedValues;
                break;
              case 'Conversation':
                ref.read(conversationFilterProvider.notifier).state =
                    updatedValues;
                break;
              case 'AgentName':
                ref.read(agentNameFilterProvider.notifier).state =
                    updatedValues;
                break;
            }
          },
        );
      }).toList(),
    );
  }
}
