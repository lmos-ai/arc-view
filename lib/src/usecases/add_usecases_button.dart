/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/text_input_dialog.dart';
import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:arc_view/src/usecases/usecase_list.dart';
import 'package:arc_view/src/usecases/usecase_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class AddUsecasesButton extends ConsumerWidget {
  const AddUsecasesButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        _newUseCase(context, ref);
      },
    );
  }

  _newUseCase(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => TextInputDialog(
        title: 'New UseCases File',
        hintText: 'usecases01',
        onConfirm: (newName) {
          ref.read(useCasesNotifierProvider.notifier).newUseCase(newName);
        },
      ),
    );
  }
}
