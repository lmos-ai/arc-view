/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/charts/models/metrics.dart';
import 'package:arc_view/src/charts/notifiers/agent_metrics_notifier.dart';
import 'package:arc_view/src/charts/services/metrics_exporter.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/core/text_input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class MetricDetails extends ConsumerWidget {
  const MetricDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(agentMetricsNotifierProvider).valueOrNull;
    if (metrics == null) {
      return const SizedBox();
    }
    return Wrap(
      spacing: 8,
      children: metrics
          .map((m) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.colorScheme.surfaceContainer,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HGap.units(2),
                    Container(color: Color(m.color), width: 10, height: 10),
                    const HGap.units(2),
                    m.name.txt,
                    SecondaryButton(
                      description: 'Edit Metric Namee',
                      icon: Icons.edit,
                      onPressed: () {
                        _editName(context, ref, m);
                      },
                    ),
                    SecondaryButton(
                      description: 'Exports Metrics',
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
          .toList(),
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
