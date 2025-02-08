/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/src/tools/models/test_tool.dart';
import 'package:arc_view/src/tools/notifiers/tools_notifier.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tools_importer.g.dart';

///
/// Imports a tool.
///
@riverpod
ToolsImporter toolsImporter(Ref ref) =>
    ToolsImporter(ref.watch(toolsNotifierProvider.notifier));

class ToolsImporter {
  ToolsImporter(this.toolsNotifier);

  final ToolsNotifier toolsNotifier;

  importTool() async {
    const XTypeGroup typeGroup = XTypeGroup(extensions: <String>['json']);
    final file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (file == null) return;
    final json = await file.readAsString();
    toolsNotifier.newTool(TestTool.fromJson(jsonDecode(json)));
  }
}
