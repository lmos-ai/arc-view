/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/events/models/agent_events.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_filter.freezed.dart';

@freezed
class EventFilter with _$EventFilter {
  factory EventFilter({
    required String label,
    required List<String> options,
    List<String>? active,
    required bool Function(AgentEvent, EventFilter) match,
  }) = _EventFilter;

  EventFilter._();

  EventFilter setActive(String option, bool isActive) {
    if (active == null && !isActive) return this;
    var updated = active ?? [];

    if (isActive) {
      updated = [...updated, option];
    } else {
      updated = updated.where((o) => o != option).toList();
    }
    return copyWith(active: updated);
  }

  bool isActive() => active != null && active!.isNotEmpty;

  EventFilter clear() => copyWith(active: null);

  ///
  /// Returns true if the event should be filtered out.
  ///
  bool shouldFilter(AgentEvent e) {
    if (active == null || active?.isEmpty == true) return false;
    return !match(e, this);
  }
}

extension Filters on List<EventFilter> {
  List<AgentEvent> applyFilters(List<AgentEvent> events) {
    return events.where((e) {
      return every((filter) => !filter.shouldFilter(e));
    }).toList();
  }
}
