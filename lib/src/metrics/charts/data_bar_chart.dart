/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/metrics/models/metrics.dart';
import "package:collection/collection.dart";
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class DataBarChart extends ConsumerWidget {
  const DataBarChart({
    super.key,
    this.maxY,
    this.title,
    required this.axisName,
    required this.plotType,
    required this.metrics,
  });

  final String? title;
  final String axisName;
  final List<Metrics> metrics;
  final PlotType plotType;
  final double? maxY;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) title!.txt,
        if (title != null) const VGap(),
        metrics.isEmpty
            ? 'No data available'.small.center().size(height: 200)
            : BarChart(
                BarChartData(
                  maxY: maxY,
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(),
                    //bottomTitles: const AxisTitles(),
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
                  barGroups: _getPlots(metrics).entries.map((entry) {
                    return BarChartGroupData(
                      barsSpace: 4,
                      x: entry.key.toInt(),
                      barRods: entry.value
                          .map(
                            (plot) => BarChartRodData(
                              toY: plot.value.y,
                              color: Color(plot.color),
                            ),
                          )
                          .toList(),
                    );
                  }).toList(),
                ),
              ).max(height: 212),
      ],
    );
  }

  Map<double, List<_PlotWithColor>> _getPlots(List<Metrics> metrics) {
    final plots = metrics
        .expand(
          (m) => m.plots.entries
              .where((e) => e.key == plotType)
              .expand((e) => e.value)
              .map((p) => _PlotWithColor(p, m.color)),
        )
        .toList();
    return groupBy(plots, (p) => p.value.x);
  }
}

class _PlotWithColor {
  final Plot value;
  final int color;

  const _PlotWithColor(this.value, this.color);
}
