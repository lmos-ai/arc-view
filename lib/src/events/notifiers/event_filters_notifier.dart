/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/src/client/notifiers/agents_notifier.dart';
import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/events/models/event_filter.dart';
import 'package:arc_view/src/events/models/event_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_filters_notifier.g.dart';

///
/// Provides active filters for the events.
///
@Riverpod(keepAlive: true)
class EventFiltersNotifier extends _$EventFiltersNotifier {
  @override
  List<EventFilter> build() {
    // Update Agent Names
    ref.listen(agentsNotifierProvider, (_, agents) {
      final agentNames = agents.valueOrNull?.names ?? [];
      state = state.map((f) {
        if (f.label == 'Agent') {
          return f.copyWith(options: agentNames);
        }
        return f;
      }).toList();
    });

    // Update Current Conversation id
    ref.listen(conversationsNotifierProvider, (_, conversations) {
      final cid = conversations.current.conversationId;
      state = state.map((f) {
        if (f.label == 'Conversation') {
          return f.copyWith(
              match: (e, filter) =>
                  e.conversationId == null || e.conversationId == cid);
        }
        return f;
      }).toList();
    });

    return [
      EventFilter(
        label: 'Agent',
        options: [],
        active: null,
        match: (e, filter) {
          var agentName = json.decode(e.payload)['agent']?['name'];
          if (agentName == null) return true;
          return filter.active?.contains(agentName) == true;
        },
      ),
      EventFilter(
        label: 'Event Type',
        options: agentEvents,
        active: null,
        match: (e, filter) {
          return filter.active?.contains(e.type) == true;
        },
      ),
      EventFilter(
        label: 'Conversation',
        options: ['Display only current conversation'],
        active: ['Display only current conversation'],
        match: (e, filter) => false,
      ),
    ];
  }

  void clearSelection() {
    state = state.map((f) => f.clear()).toList();
  }

  void updateFilter(EventFilter filter) {
    state = state.map((f) {
      if (f.label == filter.label) {
        return filter;
      }
      return f;
    }).toList();
  }
}

extension EventFiltersNotifierExtension on WidgetRef {
  updateFilter(EventFilter filter) {
    read(eventFiltersNotifierProvider.notifier).updateFilter(filter);
  }
}
