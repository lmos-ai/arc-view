/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/app_bar_title.dart';
import 'package:arc_view/src/usecases/buttons/add_usecases_button.dart';
import 'package:arc_view/src/usecases/buttons/import_usecases_button.dart';
import 'package:arc_view/src/usecases/usecase_table.dart';
import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';
import 'package:url_launcher/url_launcher_string.dart';

///
/// Main screen for managing UseCases.
///
class UseCasesScreen extends StatelessWidget {
  const UseCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTitle('Use Cases'),
      floatingActionButton: [
        ImportUseCasesButton(),
        HGap.small(),
        AddUseCasesButton(),
      ].row(min: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ColoredBox(
                color: context.colorScheme.surfaceContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Create and Manage your Use Cases.'.txt,
                    'For more information on Use Cases, please visit'.txt,
                    'https://eclipse.dev/lmos/docs/arc/use_cases/'
                        .onPressed(() {
                      launchUrlString(
                          'https://eclipse.dev/lmos/docs/arc/use_cases/');
                    }),
                  ],
                ).padByUnits(2, 3, 2, 3),
              ).size(height: 100),
              HGap.small(),
              ColoredBox(
                color: context.colorScheme.surfaceContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Predefined Tags:'.txt,
                    '${tagColors.keys.join(', ')}'.txt,
                  ],
                ).padByUnits(2, 3, 2, 3),
              ).size(height: 100)
            ],
          ).padByUnits(3, 3, 0, 3),
          UseCaseTable().padByUnits(3, 3, 3, 3).expand(),
        ],
      ).size(width: double.infinity),
    );
  }
}
