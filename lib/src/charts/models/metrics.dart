/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'metrics.freezed.dart';
part 'metrics.g.dart';

@freezed
class Metrics with _$Metrics {
  factory Metrics({
    required int color,
    required String name,
    String? conversationId,
    required Map<PlotType, List<Plot>> plots,
  }) = _Metrics;

  factory Metrics.fromJson(Map<String, dynamic> json) =>
      _$MetricsFromJson(json);
}

@freezed
class Plot with _$Plot {
  factory Plot({
    required double x,
    required double y,
  }) = _Plot;

  factory Plot.fromJson(Map<String, dynamic> json) => _$PlotFromJson(json);
}

enum PlotType {
  agentDuration,
  agentBreaks,
  llmTotalTokens,
  llmFunctionCalls,
  llmDuration,
  llmPromptTokens,
  llmCompletionTokens,
}
