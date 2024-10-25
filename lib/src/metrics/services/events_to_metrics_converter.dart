/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/src/conversation/services/conversation_colors.dart';
import 'package:arc_view/src/events/models/agent_events.dart';
import 'package:arc_view/src/metrics/models/metrics.dart';
import "package:collection/collection.dart";
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_to_metrics_converter.g.dart';

@riverpod
EventsToMetricsConverter eventsToMetricsConverter(
    EventsToMetricsConverterRef ref) {
  return EventsToMetricsConverter();
}

class EventsToMetricsConverter {
  Future<List<Metrics>> convert(List<AgentEvent> events) async {
    //return await Isolate.run(() => _convert(events));
    return _convert(events);
  }

  List<Metrics> _convert(List<AgentEvent> events) {
    Map<String, List<AgentEvent>> groupedEvents =
        groupBy(events, (e) => e.conversationId ?? '');

    return groupedEvents.keys.map((key) {
      final conversationId = key.toString();
      final events = groupedEvents[key]!;
      Map<PlotType, List<Plot>> allPlots = {};

      for (var i = events.length - 1; i >= 0; i--) {
        final event = events[i];
        final plots =
            _transformEvent(event.type, jsonDecode(event.payload), allPlots);
        for (var entry in plots.entries) {
          allPlots[entry.key] =
              (allPlots[entry.key]?..add(entry.value)) ?? [entry.value];
        }
      }
      return Metrics(
        name: conversationId,
        conversationId: conversationId,
        color: color(conversationId).value,
        plots: allPlots,
      );
    }).toList();
  }

  Map<PlotType, Plot> _transformEvent(
      String type, dynamic json, Map<PlotType, List<Plot>> allPlots) {
    return switch (type) {
      'AgentFinishedEvent' => {
          PlotType.agentDuration: Plot(
              x: allPlots[PlotType.agentDuration]?.length.toDouble() ?? 0,
              y: json['duration'].toDouble()),
          PlotType.agentBreaks: Plot(
              x: allPlots[PlotType.agentBreaks]?.length.toDouble() ?? 0,
              y: json['flowBreak'] ? 1.0 : 0.0),
        },
      'LLMFinishedEvent' => {
          PlotType.llmTotalTokens: Plot(
              x: allPlots[PlotType.llmTotalTokens]?.length.toDouble() ?? 0,
              y: json['totalTokens'].toDouble()),
          PlotType.llmFunctionCalls: Plot(
              x: allPlots[PlotType.llmFunctionCalls]?.length.toDouble() ?? 0,
              y: json['functionCallCount'].toDouble()),
          PlotType.llmPromptTokens: Plot(
              x: allPlots[PlotType.llmPromptTokens]?.length.toDouble() ?? 0,
              y: json['promptTokens'].toDouble()),
          PlotType.llmCompletionTokens: Plot(
              x: allPlots[PlotType.llmCompletionTokens]?.length.toDouble() ?? 0,
              y: json['completionTokens'].toDouble()),
          PlotType.llmDuration: Plot(
              x: allPlots[PlotType.llmDuration]?.length.toDouble() ?? 0,
              y: json['duration'].toDouble()),
        },
      _ => {},
    };
  }
}
