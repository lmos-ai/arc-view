/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:arc_view/src/usecases/usecase_list.dart';
import 'package:arc_view/src/usecases/usecase_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class UseCasesScreen extends StatefulWidget {
  const UseCasesScreen({super.key});

  @override
  State<UseCasesScreen> createState() => _UseCasesScreenState();
}

class _UseCasesScreenState extends State<UseCasesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) => Scaffold(
          appBar: AppBar(
            title: 'Use Cases'.txt,
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              ref.read(useCasesNotifierProvider.notifier).newUseCase();
            },
          ),
          body: Row(
            children: [
              UseCasePanel().expand(),
              Container(
                width: 1,
                color: context.colorScheme.surfaceContainer,
              ),
              UseCaseList().size(width: 200).padByUnits(0, 1, 0, 1),
            ],
          )),
    );
  }
}
