/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/core/text_input_dialog.dart';
import 'package:arc_view/src/metrics/models/metrics.dart';
import 'package:arc_view/src/metrics/notifiers/agent_metrics_notifier.dart';
import 'package:arc_view/src/metrics/services/metrics_exporter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class MetricDetails extends ConsumerWidget {
  const MetricDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(agentMetricsNotifierProvider).valueOrNull;
    if (metrics == null || metrics.isEmpty) {
      return const SizedBox();
    }
    final selectMetricNotifier =
        ref.read(agentMetricsNotifierProvider.notifier);
    // Check if all metrics are selected
    final allSelected = metrics
        .every((m) => selectMetricNotifier.selectedMetrics.contains(m.name));

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // 'ALL' checkbox
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colorScheme.surfaceContainer,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: allSelected,
                onChanged: (isSelected) {
                  selectMetricNotifier.toggleAllMetrics(
                      isSelected ?? false, metrics);
                },
              ),
              const HGap.units(2),
              " ALL ".txt,
            ],
          ),
        ),
        // Metrics list
        ...metrics.map((m) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colorScheme.surfaceContainer,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value:
                        selectMetricNotifier.selectedMetrics.contains(m.name),
                    onChanged: (isSelected) {
                      selectMetricNotifier.toggleMetric(
                          m.name, isSelected ?? false);
                    },
                  ),
                  const HGap.units(2),
                  Container(color: Color(m.color), width: 10, height: 10),
                  const HGap.units(2),
                  m.name.txt,
                  SecondaryButton(
                    description: 'Edit Metric Name',
                    icon: Icons.edit,
                    onPressed: () {
                      _editName(context, ref, m);
                    },
                  ),
                  SecondaryButton(
                    description: 'Export Metrics',
                    icon: Icons.download,
                    onPressed: () {
                      ref.read(metricsExporterProvider).export(m);
                    },
                  ),
                  if (m.conversationId != null)
                    SecondaryButton(
                      description: 'Delete Metric',
                      icon: Icons.delete,
                      onPressed: () {
                        ref
                            .read(agentMetricsNotifierProvider.notifier)
                            .remove(m.conversationId!);
                      },
                    ),
                ],
              ),
            ))
      ],
    );
  }

  _editName(BuildContext context, WidgetRef ref, Metrics metrics) {
    showDialog(
      context: context,
      builder: (context) => TextInputDialog(
        title: 'Edit Metric Name',
        hintText: metrics.name,
        onConfirm: (newName) {
          final conversationId = metrics.conversationId;
          if (conversationId == null) return;
          ref
              .read(agentMetricsNotifierProvider.notifier)
              .editName(conversationId, newName);
        },
      ),
    );
  }
}
