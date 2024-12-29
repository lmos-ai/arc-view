/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/add_usecases_button.dart';
import 'package:arc_view/src/usecases/usecase_list.dart';
import 'package:arc_view/src/usecases/usecase_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smiles/smiles.dart';

///
/// Main screen for managing UseCases.
///
class UseCasesScreen extends StatelessWidget {
  const UseCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'Use Cases'.txt.animate().fadeIn()),
      floatingActionButton: AddUsecasesButton(),
      body: Row(
        children: [
          UseCasePanel().expand(),
          Container(width: 1, color: context.colorScheme.surfaceContainer),
          UseCaseList().size(width: 220).padByUnits(0, 1, 0, 1),
        ],
      ),
    );
  }
}
