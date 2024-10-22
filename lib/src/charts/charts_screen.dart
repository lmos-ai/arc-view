/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/charts/agent_duration_chart.dart';
import 'package:arc_view/src/charts/agent_flowbreaks_chart.dart';
import 'package:arc_view/src/charts/function_calls_chart.dart';
import 'package:arc_view/src/charts/tokens_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class ChartsScreen extends ConsumerWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: 'Performance'.txt),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            const TokensChart().percentOfScreen(width: 0.45),
            const Spacer(),
            const FunctionCallsChart().percentOfScreen(width: 0.45),
          ].row(),
        ],
      ).padByUnits(4, 4, 4, 4),
    );
  }
}
