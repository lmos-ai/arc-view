/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';
import 'dart:typed_data';

import 'package:arc_view/src/metrics/models/metrics.dart';
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
    _export(metrics, fileName, result);
    //await Isolate.run(() async {
    //  await _export(metrics, fileName, result);
    //});
  }

  _export(Metrics metrics, String fileName, FileSaveLocation location) async {
    final Uint8List fileData = utf8.encode(jsonEncode(metrics.toJson()));
    final XFile textFile = XFile.fromData(
      fileData,
      mimeType: 'application/json',
      name: fileName,
    );
    await textFile.saveTo(location.path);
  }
}
