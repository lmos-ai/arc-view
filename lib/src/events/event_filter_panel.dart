/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/events/events_list.dart';
import 'package:arc_view/src/events/models/event_filter.dart';
import 'package:arc_view/src/events/notifiers/event_filters_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:smiles/smiles.dart';

///
/// Panel for configuring the filtering of events.
///
class EventFilterPanel extends ConsumerWidget {
  const EventFilterPanel({super.key});

  static final _log = Logger('EventFilterPanel');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(eventFiltersNotifierProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SecondaryButton(
              icon: Icons.arrow_back,
              description: 'Close Filters',
              onPressed: () {
                ref.read(filterDrawerProvider.notifier).state = false;
              },
            ),
            'Filters'.txt,
            SecondaryButton(
              description: 'Clear filters',
              onPressed: () {
                ref
                    .read(eventFiltersNotifierProvider.notifier)
                    .clearSelection();
              },
              icon: Icons.filter_alt_off,
            ),
          ],
        ),
        // Filter List
        Expanded(
          child: ListView(
            children: options.map((o) => _buildFilterGroup(o, ref)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterGroup(EventFilter filter, WidgetRef ref) {
    return ExpansionTile(
      title: filter.label.txt,
      children: filter.options.map((option) {
        final isSelected = filter.active?.contains(option) == true;
        return CheckboxListTile(
          title: Text(option),
          value: isSelected,
          onChanged: (bool? value) {
            _log.finer('Filtering by $option: $value');
            ref.updateFilter(filter.setActive(option, value == true));
          },
        );
      }).toList(),
    );
  }
}
