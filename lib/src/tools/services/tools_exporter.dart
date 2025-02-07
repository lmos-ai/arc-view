/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';
import 'dart:typed_data';

import 'package:arc_view/src/tools/models/test_tool.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tools_exporter.g.dart';

///
/// Exports a use case file.
///
@riverpod
ToolsExporter toolsExporter(Ref ref) => ToolsExporter();

class ToolsExporter {
  ToolsExporter();

  export(TestTool tool) async {
    final fileName = '${tool.name}.json';
    final result = await getSaveLocation(suggestedName: fileName);
    if (result == null) return;
    _export(tool, fileName, result);
  }

  _export(
    TestTool tool,
    String fileName,
    FileSaveLocation location,
  ) async {
    final Uint8List fileData = utf8.encode(jsonEncode(tool.toJson()));
    final XFile textFile = XFile.fromData(
      fileData,
      mimeType: 'application/json',
      name: fileName,
    );
    await textFile.saveTo(location.path);
  }
}
