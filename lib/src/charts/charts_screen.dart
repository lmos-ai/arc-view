/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/charts/agent_duration_chart.dart';
import 'package:arc_view/src/charts/agent_flowbreaks_chart.dart';
import 'package:arc_view/src/charts/function_calls_chart.dart';
import 'package:arc_view/src/charts/llm_duration_chart.dart';
import 'package:arc_view/src/charts/metric_details.dart';
import 'package:arc_view/src/charts/services/metrics_importer.dart';
import 'package:arc_view/src/charts/tokens_chart.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class ChartsScreen extends ConsumerWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: 'Performance'.txt),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                'Conversations'.h3,
                SecondaryButton(
                  description: 'Import Metrics',
                  icon: Icons.upload,
                  onPressed: () {
                    ref.read(metricsImporterProvider).load();
                  },
                ),
              ],
            ),
            const VGap.units(2),
            const MetricDetails(),
            const VGap.medium(),
            'Agent Metrics'.h3,
            const VGap.units(2),
            [
              const AgentDurationChart().percentOfScreen(width: 0.45),
              const Spacer(),
              const AgentFlowBreaksChart().percentOfScreen(width: 0.45),
            ].row(),
            const VGap.medium(),
            'LLM Metrics'.h3,
            const VGap.units(2),
            [
              const LLMDurationChart().percentOfScreen(width: 0.45),
              const Spacer(),
              const FunctionCallsChart().percentOfScreen(width: 0.45),
            ].row(),
            const VGap.medium(),
            'LLM Tokens'.h3,
            const VGap.units(2),
            [
              const TokensChart().percentOfScreen(width: 0.3),
              const Spacer(),
              const PromptTokensChart().percentOfScreen(width: 0.3),
              const Spacer(),
              const CompletionTokensChart().percentOfScreen(width: 0.3),
            ].row(),
            const VGap.units(2),
          ],
        ).padByUnits(4, 4, 4, 4),
      ),
    );
  }
}
