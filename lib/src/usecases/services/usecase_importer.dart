/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecase_importer.g.dart';

///
/// Imports a use case file.
///
@riverpod
UseCaseImporter useCaseImporter(Ref ref) =>
    UseCaseImporter(ref.watch(useCasesNotifierProvider.notifier));

class UseCaseImporter {
  UseCaseImporter(this.useCasesNotifier);

  final UseCasesNotifier useCasesNotifier;

  importUseCases() async {
    const XTypeGroup typeGroup = XTypeGroup(extensions: <String>['md']);
    final file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (file == null) return;
    final md = await file.readAsString();
    useCasesNotifier.newUseCase(file.name.replaceAll('.md', ''), content: md);
  }
}
