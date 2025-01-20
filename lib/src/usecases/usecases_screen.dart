/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/buttons/add_usecases_button.dart';
import 'package:arc_view/src/usecases/buttons/import_usecases_button.dart';
import 'package:arc_view/src/usecases/usecase_list.dart';
import 'package:arc_view/src/usecases/usecase_panel.dart';
import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';

///
/// Main screen for managing UseCases.
///
class UseCasesScreen extends StatelessWidget {
  const UseCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'Use Cases'.txt),
      floatingActionButton: [
        ImportUseCasesButton(),
        HGap.small(),
        AddUseCasesButton(),
      ].row(min: true),
      body: Row(
        children: [
          UseCasePanel().expand(),
          UseCaseList().size(width: 220).padByUnits(0, 1, 0, 1),
        ],
      ),
    );
  }
}
