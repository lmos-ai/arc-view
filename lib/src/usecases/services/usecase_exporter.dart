/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';
import 'dart:typed_data';

import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecase_exporter.g.dart';

///
/// Exports a use case file.
///
@riverpod
UseCaseExporter useCaseExporter(Ref ref) => UseCaseExporter();

class UseCaseExporter {
  UseCaseExporter();

  export(UseCase useCase) async {
    final fileName = '${useCase.name.replaceAll(' ', '_')}.md';
    final result = await getSaveLocation(suggestedName: fileName);
    if (result == null) return;
    _export(useCase, fileName, result);
  }

  _export(UseCase useCase, String fileName, FileSaveLocation location) async {
    final Uint8List fileData = utf8.encode(useCase.content);
    final XFile textFile = XFile.fromData(
      fileData,
      mimeType: 'text/markdown',
      name: fileName,
    );
    await textFile.saveTo(location.path);
  }
}
