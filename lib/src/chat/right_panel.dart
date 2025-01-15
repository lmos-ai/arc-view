/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/conversation/conversations_panel.dart';
import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/events/events_list.dart';
import 'package:arc_view/src/events/events_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

import '../events/notifiers/agent_events_notifier.dart';

class RightPanel extends StatelessWidget {
  const RightPanel({super.key, this.width = 300});

  final double width;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TabBarView(
            children: [
              EventsPanel(),
              ConversationsPanel(),
            ],
          ).expand(),
          VGap.units(3),
          _SwitchTabs().size(height: 32),
        ],
      ).percentOfScreen(width: 0.3).padByUnits(0, 2, 2, 2),
    );
  }
}

class _SwitchTabs extends ConsumerWidget {
  const _SwitchTabs();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(
        conversationsNotifierProvider.select((e) => e.conversations.length));

    //Events count
    final eventsCount = ref.watch(agentEventsNotifierProvider.select(
      (list) => list.where((e) {
        return EventsList.handleEvents.contains(e.type) &&
            EventsList.applyFiltersAndSorting(e, ref);
      }).length,
    ));

    return Card(
        color: context.colorScheme.surfaceContainer,
        margin: const EdgeInsets.all(0),
        child: TabBar(
          dividerHeight: 0,
          tabs: [
            Tab(text: 'Events ($eventsCount)'),
            Tab(child: ['Conversations ($count)'.txt].row(min: true)),
          ],
        ));
  }
}
