/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/events/events_list.dart';
import 'package:arc_view/src/events/notifiers/agent_events_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smiles/smiles.dart';

// Provider for sorting state (ASC or DESC)
final selectedSortProvider = StateProvider<String>((ref) => 'DESC');

class EventsPanel extends ConsumerWidget {
  const EventsPanel({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSort = ref.watch(selectedSortProvider);
    return Card(
      margin: const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                SecondaryButton(
                  description: 'Show Charts',
                  onPressed: () {
                    context.push("/charts");
                  },
                  icon: Icons.bar_chart,
                ),
                // Filter Button
                SecondaryButton(
                  description: 'Filter Events',
                  icon: Icons.filter_alt,
                  onPressed: () {
                    ref.read(filterDrawerProvider.notifier).state =
                        !ref.watch(filterDrawerProvider);
                  },
                ),
                // Sort Button
                SecondaryButton(
                  description: 'Sort $currentSort',
                  icon: currentSort == 'DESC'
                      ? Icons.arrow_circle_down
                      : Icons.arrow_circle_up,
                  onPressed: () {
                    // Toggle between ASC and DESC
                    ref.read(selectedSortProvider.notifier).state =
                        currentSort == 'ASC' ? 'DESC' : 'ASC';
                  },
                ),
              ]),
              SecondaryButton(
                description: 'Reset Events',
                onPressed: () {
                  ref.read(agentEventsNotifierProvider.notifier).reset();
                },
                icon: Icons.delete,
              ),
            ],
          ),
          EventsList().expand()
        ],
      ),
    );
  }
}
