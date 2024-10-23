/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:arc_view/src/charts/models/metrics.dart';
import 'package:file_selector/file_selector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'metrics_exporter.g.dart';

@riverpod
MetricsExporter metricsExporter(MetricsExporterRef ref) {
  return MetricsExporter();
}

///
/// Exports metrics to a JSON file.
///
class MetricsExporter {
  MetricsExporter();

  export(Metrics metrics) async {
    final fileName = 'metrics_${metrics.name.replaceAll(' ', '')}.json';
    final result = await getSaveLocation(suggestedName: fileName);
    if (result == null) return;
    Isolate.run(() {
      final Uint8List fileData =
          Uint8List.fromList(jsonEncode(metrics.toJson()).codeUnits);
      final XFile textFile = XFile.fromData(
        fileData,
        mimeType: 'application/json',
        name: fileName,
      );
      textFile.saveTo(result.path);
    });
  }
}
