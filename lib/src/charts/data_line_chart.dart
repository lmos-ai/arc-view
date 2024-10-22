/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/charts/models/metrics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class DataLineChart extends ConsumerWidget {
  const DataLineChart({
    super.key,
    this.maxY,
    required this.title,
    required this.axisName,
    required this.plotType,
    required this.metrics,
  });

  final String title;
  final String axisName;
  final List<Metrics> metrics;
  final PlotType plotType;
  final double? maxY;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        title.txt,
        const VGap(),
        metrics.isEmpty
            ? 'No data available'.small.center().size(height: 200)
            : LineChart(
                LineChartData(
                  maxY: maxY,
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(),
                    bottomTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    leftTitles: AxisTitles(
                      axisNameWidget: axisName.txt,
                      sideTitles: const SideTitles(
                        reservedSize: 44,
                        showTitles: true,
                      ),
                    ),
                  ),
                  minY: 0,
                  lineBarsData: metrics.map((metric) {
                    return LineChartBarData(
                      spots: metric.plots.entries
                          .where((e) => e.key == plotType)
                          .expand((e) => e.value)
                          .map((p) => FlSpot(p.x.toDouble(), p.y.toDouble()))
                          .toList(),
                      color: metric.color,
                    );
                  }).toList(),
                ),
              ).max(height: 200),
      ],
    );
  }
}
