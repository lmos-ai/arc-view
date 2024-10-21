/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'metrics.freezed.dart';

@freezed
class Metrics with _$Metrics {
  factory Metrics({
    required Color color,
    required String name,
    String? conversationId,
    required Map<PlotType, List<Plot>> plots,
  }) = _Metrics;
}

@freezed
class Plot with _$Plot {
  factory Plot({
    required double x,
    required double y,
  }) = _Plot;
}

enum PlotType {
  agentDuration,
  agentBreaks,
  llmTotalTokens,
  llmFunctionCalls,
}
