/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/metrics/charts/data_bar_chart.dart';
import 'package:arc_view/src/metrics/charts/data_line_chart.dart';
import 'package:arc_view/src/metrics/models/metrics.dart';
import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';

class DataChart extends StatefulWidget {
  const DataChart({
    super.key,
    required this.title,
    required this.axisName,
    required this.plotType,
    required this.metrics,
    this.defaultChartType = ChartType.bar,
    this.maxY,
  });

  final String title;
  final String axisName;
  final List<Metrics> metrics;
  final PlotType plotType;
  final double? maxY;
  final ChartType defaultChartType;

  @override
  State<DataChart> createState() => _DataChartState();
}

class _DataChartState extends State<DataChart> {
  ChartType chartType = ChartType.bar;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        [
          widget.title.txt,
          SecondaryButton(
            icon: chartType == ChartType.line
                ? Icons.bar_chart
                : Icons.show_chart,
            description:
                'Switch to ${chartType == ChartType.line ? 'Bar' : 'Line'} Chart',
            onPressed: () {
              setState(() {
                chartType = chartType == ChartType.line
                    ? ChartType.bar
                    : ChartType.line;
              });
            },
          )
        ].row(min: true),
        const VGap(),
        chartType == ChartType.line
            ? DataLineChart(
                axisName: widget.axisName,
                metrics: widget.metrics,
                plotType: widget.plotType,
                maxY: widget.maxY,
              )
            : DataBarChart(
                axisName: widget.axisName,
                metrics: widget.metrics,
                plotType: widget.plotType,
                maxY: widget.maxY,
              )
      ],
    );
  }

  @override
  void initState() {
    chartType = widget.defaultChartType;
    super.initState();
  }
}

enum ChartType {
  bar,
  line,
}
