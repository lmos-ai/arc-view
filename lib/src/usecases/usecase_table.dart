/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/usecases/dialogs/usecase_dialog.dart';
import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:arc_view/src/usecases/services/usecase_exporter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smiles/smiles.dart';

const _columnSizes = <double>[240, 300, 180, 180, 220];

class UseCaseTable extends ConsumerWidget {
  const UseCaseTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useCases = ref.watch(useCasesNotifierProvider).valueOrNull;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final largeScreen = screenWidth > 1400;
    final smallScreen = screenWidth < 1200;

    if (useCases == null || useCases.cases.isEmpty) {
      return ''.txt.pad(4, 8, 4, 8);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child: DataTable(
              showCheckboxColumn: false,
              headingRowHeight: 40,
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => context.colorScheme.surfaceContainer,
              ),
              columns: [
                DataColumn(
                    numeric: false,
                    label: 'Name'.txt,
                    onSort: (columnIndex, ascending) {
                      ref
                          .read(useCasesNotifierProvider.notifier)
                          .sortByName(ascending: ascending);
                    },
                    columnWidth: FixedColumnWidth(_columnSizes[0])),
                DataColumn(
                    label: 'Description'.txt, columnWidth: FlexColumnWidth()),
                if (!smallScreen)
                  DataColumn(
                      label: 'Tags'.txt,
                      columnWidth: FixedColumnWidth(_columnSizes[1])),
                DataColumn(
                    label: 'Created At'.txt,
                    columnWidth: FixedColumnWidth(_columnSizes[2])),
                if (largeScreen)
                  DataColumn(
                      label: 'Hash'.txt,
                      columnWidth: FixedColumnWidth(_columnSizes[3])),
                DataColumn(
                    label: 'Actions'.txt,
                    columnWidth: FixedColumnWidth(_columnSizes[4])),
              ],
              rows: [
                for (var i = 0; i < useCases.cases.length; i++)
                  DataRow(
                    onSelectChanged: (selected) {
                      if (selected == true) {
                        _gotoUseCase(useCases.cases[i], context);
                      }
                    },
                    cells: [
                      DataCell(
                        [
                          Icon(
                            Icons.file_open_rounded,
                            size: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          HGap.units(2),
                          useCases.cases[i].name.txt,
                        ].row(),
                      ),
                      DataCell(
                        (useCases.cases[i].description ?? '').txt,
                      ),
                      if (!smallScreen)
                        DataCell(
                          UseCaseTags(useCase: useCases.cases[i]),
                        ),
                      DataCell(DateFormat.Hm()
                          .add_yMd()
                          .format(useCases.cases[i].createdAt)
                          .txt),
                      if (largeScreen)
                        DataCell(
                          useCases.cases[i].generateHash().txt,
                        ),
                      DataCell([
                        SecondaryButton(
                            icon: Icons.edit,
                            description: 'Edit Use Case Details',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => UseCaseDialog(
                                  title: 'Edit UseCases Details',
                                  value: useCases.cases[i],
                                  onConfirm: (details) {
                                    ref
                                        .read(useCasesNotifierProvider.notifier)
                                        .updateUseCase(
                                            useCases.cases[i].copyWith(
                                          name: details.name,
                                          description: details.description,
                                          tags: details.tags,
                                        ));
                                  },
                                ),
                              );
                            }),
                        SecondaryButton(
                            icon: Icons.download,
                            description: 'Export Use Case',
                            onPressed: () {
                              ref
                                  .read(useCaseExporterProvider)
                                  .export(useCases.cases[i]);
                            }),
                        SecondaryButton(
                            icon: Icons.copy,
                            description: 'Duplicate Use Case',
                            onPressed: () {
                              ref
                                  .read(useCasesNotifierProvider.notifier)
                                  .addUseCase(useCases.cases[i].duplicate());
                            }),
                        SecondaryButton(
                            icon: Icons.delete,
                            confirming: true,
                            description: 'Delete Use Case',
                            onPressed: () {
                              ref
                                  .read(useCasesNotifierProvider.notifier)
                                  .deleteUseCase(useCases.cases[i]);
                            }),
                      ].row()),
                    ],
                  )
              ]),
        ).expand(),
      ],
    );
  }

  _gotoUseCase(UseCase useCase, BuildContext context) {
    context.push('/edit_usecase/${useCase.id}');
  }
}

Map<String, Color> tagColors = {
  'ready': Colors.teal[900] ?? Colors.teal,
  'verified': Colors.teal[900] ?? Colors.teal,
  'prod': Colors.blue[900] ?? Colors.blue,
  'live': Colors.blue[900] ?? Colors.blue,
  'test': Colors.purple[900] ?? Colors.purple,
  'broken': Colors.red[900] ?? Colors.red,
};

class UseCaseTags extends StatefulWidget {
  const UseCaseTags({super.key, required this.useCase});

  final UseCase useCase;

  @override
  State<UseCaseTags> createState() => _UseCaseTagsState();
}

class _UseCaseTagsState extends State<UseCaseTags> {
  @override
  Widget build(BuildContext context) {
    return <Widget>[
      ...(widget.useCase.tags
              ?.map((t) => Container(
                    decoration: BoxDecoration(
                      color:
                          tagColors[t] ?? context.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: t.txt.padByUnits(0, 1, 0, 1),
                  ))
              .toList() ??
          []),
    ].wrap(spacing: 8);
  }
}
