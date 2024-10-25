/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/events/notifiers/agent_events_notifier.dart';
import 'package:arc_view/src/metrics/models/metrics.dart';
import 'package:arc_view/src/metrics/services/events_to_metrics_converter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_metrics_notifier.g.dart';

@Riverpod(keepAlive: true)
class AgentMetricsNotifier extends _$AgentMetricsNotifier {
  @override
  Future<List<Metrics>> build() async {
    final events = ref.watch(agentEventsNotifierProvider).toList();
    final converter = ref.read(eventsToMetricsConverterProvider);
    final newMetrics = await converter.convert(events);
    if (!state.hasValue) return newMetrics;
    return [
      ...newMetrics.map((m) => m.copyWith(name: _getName(m.conversationId))),
      ...state.valueOrNull!
          .where((e) => !_contains(newMetrics, e.conversationId))
    ];
  }

  String _getName(String? conversationId) {
    if (conversationId == null) return '';
    final metrics = state.valueOrNull;
    if (metrics == null) return conversationId;
    final metric =
        metrics.firstWhere((m) => m.conversationId == conversationId);
    return metric.name;
  }

  bool _contains(List<Metrics> metrics, String? conversationId) {
    return metrics.any((m) => m.conversationId == conversationId);
  }

  editName(String conversationId, String newName) {
    final oldState = state.valueOrNull;
    if (oldState == null) return;

    state = AsyncData(oldState.map((m) {
      if (m.conversationId == conversationId) return m.copyWith(name: newName);
      return m;
    }).toList());
  }

  add(Metrics metrics) {
    final oldState = state.valueOrNull;
    if (oldState == null) return;
    state = AsyncData([...oldState, metrics]);
  }

  remove(String conversationId) {
    final oldState = state.valueOrNull;
    if (oldState == null) return;
    state = AsyncData(
        [...oldState.where((e) => e.conversationId != conversationId)]);
  }
}
