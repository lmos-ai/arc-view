/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/charts/data_line_chart.dart';
import 'package:arc_view/src/charts/models/metrics.dart';
import 'package:arc_view/src/charts/notifiers/agent_metrics_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokensChart extends ConsumerWidget {
  const TokensChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(agentMetricsNotifierProvider).valueOrNull;
    return DataLineChart(
      title: 'Total Tokens',
      axisName: 'Tokens',
      metrics: metrics ?? const [],
      plotType: PlotType.llmTotalTokens,
    );
  }
}
