/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/src/metrics/models/metrics.dart';
import 'package:arc_view/src/metrics/notifiers/agent_metrics_notifier.dart';
import 'package:file_selector/file_selector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'metrics_importer.g.dart';

@riverpod
MetricsImporter metricsImporter(MetricsImporterRef ref) {
  return MetricsImporter(ref.watch(agentMetricsNotifierProvider.notifier));
}

///
/// Exports metrics to a JSON file.
///
class MetricsImporter {
  MetricsImporter(this.agentMetricsNotifier);

  final AgentMetricsNotifier agentMetricsNotifier;

  load() async {
    const XTypeGroup typeGroup = XTypeGroup(extensions: <String>['json']);
    final file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (file == null) return;
    final json = await file.readAsString();
    agentMetricsNotifier.add(Metrics.fromJson(jsonDecode(json)));
  }
}
