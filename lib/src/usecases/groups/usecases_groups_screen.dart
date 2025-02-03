/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/groups/usecase_group_panel.dart';
import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';

///
/// Main screen for managing UseCase Groups.
///
class UseCasesGroupsScreen extends StatelessWidget {
  const UseCasesGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'Use Cases'.txt),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VGap.medium(),
          'Groups'.h3.padding(),
          VGap.small(),
          Wrap(
            children: [
              UseCaseGroupPanel(
                name: 'Use Case Based Agents',
              ),
              HGap(),
              UseCaseGroupPanel(
                name: 'Agent Chat',
              ),
            ],
          ).expand(),
          VGap.small(),
          'Last Viewed'.h3.padding(),
          Spacer(),
        ],
      ).padByUnits(0, 3, 0, 3),
    );
  }
}
