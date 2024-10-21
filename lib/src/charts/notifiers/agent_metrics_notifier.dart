/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';
import 'dart:isolate';

import 'package:arc_view/src/charts/models/metrics.dart';
import 'package:arc_view/src/events/models/agent_events.dart';
import 'package:arc_view/src/events/notifiers/agent_events_notifier.dart';
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_metrics_notifier.g.dart';

@riverpod
class AgentMetricsNotifier extends _$AgentMetricsNotifier {
  @override
  Future<List<Metrics>> build() async {
    final events = ref.watch(agentEventsNotifierProvider).toList();

    final result = await Isolate.run(() {
      return _build(events);
    });
    return result;
  }

  static Map<PlotType, Plot> _transformEvent(
      String type, dynamic json, int index) {
    return switch (type) {
      'AgentFinishedEvent' => {
          PlotType.agentDuration:
              Plot(x: index.toDouble(), y: json['duration'].toDouble())
        },
      'LLMFinishedEvent' => {
          PlotType.llmTotalTokens:
              Plot(x: index.toDouble(), y: json['totalTokens'].toDouble())
        },
      _ => {},
    };
  }

  static List<Metrics> _build(List<AgentEvent> events) {
    Map<String, List<AgentEvent>> groupedEvents =
        groupBy(events, (e) => e.conversationId ?? '');

    return groupedEvents.keys.map((key) {
      final conversationId = key.toString();
      final events = groupedEvents[key]!;
      Map<PlotType, List<Plot>> allPlots = {};

      for (var i = 0; i < events.length - 1; i++) {
        final event = events[i];
        final plots = _transformEvent(event.type, jsonDecode(event.payload), i);
        for (var entry in plots.entries) {
          allPlots[entry.key] =
              (allPlots[entry.key]?..add(entry.value)) ?? [entry.value];
        }
      }
      return Metrics(
        name: conversationId,
        conversationId: conversationId,
        color: allColors[conversationId.hashCode % allColors.length],
        plots: allPlots,
      );
    }).toList();
  }
}

const allColors = [
  Colors.green,
  Colors.red,
  Colors.blue,
  Colors.yellow,
  Colors.purple,
  Colors.orange,
  Colors.pink,
  Colors.teal,
  Colors.cyan,
  Colors.lime,
  Colors.indigo,
  Colors.amber,
  Colors.brown,
  Colors.grey,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.lightBlue,
];
