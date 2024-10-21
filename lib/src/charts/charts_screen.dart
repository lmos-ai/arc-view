/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/charts/agent_duration_chart.dart';
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
      body: const Wrap(
        spacing: 64,
        runSpacing: 64,
        children: [
          AgentDurationChart(),
          TokensChart(),
        ],
      ).padding(32),
    );
  }
}
