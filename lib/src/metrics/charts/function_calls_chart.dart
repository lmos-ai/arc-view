/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/metrics/charts/data_chart.dart';
import 'package:arc_view/src/metrics/models/metrics.dart';
import 'package:arc_view/src/metrics/notifiers/agent_metrics_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FunctionCallsChart extends ConsumerWidget {
  const FunctionCallsChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(agentMetricsNotifierProvider).valueOrNull;
    // Watch the selected metrics from the notifier
    final selectedMetrics = ref.watch(agentMetricsNotifierProvider.notifier).selectedMetrics;
    // Filter metrics based on the selected metrics
    final filteredMetrics = metrics?.where((m) => selectedMetrics.contains(m.name)).toList() ?? [];
    return DataChart(
      title: 'Function Calls',
      axisName: 'Calls',
      metrics: filteredMetrics,
      plotType: PlotType.llmFunctionCalls,
    );
  }
}
