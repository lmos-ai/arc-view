/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:arc_view/src/usecases/usecase_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

///
/// Main screen for editing UseCases.
///
class EditUseCasesScreen extends ConsumerWidget {
  const EditUseCasesScreen({super.key, required this.useCaseId});

  final String useCaseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCase = ref.watch(useCasesNotifierProvider
        .select((u) => u.valueOrNull?.getById(useCaseId)));

    return Scaffold(
      appBar: AppBar(title: 'Use Case ${selectedCase?.name}'.txt),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          UseCasePanel(useCaseId: useCaseId).padByUnits(0, 1, 1, 1).expand(),
        ],
      ),
    );
  }
}
