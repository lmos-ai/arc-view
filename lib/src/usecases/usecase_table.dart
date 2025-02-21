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

const _columnSizes = <double>[240, 300, 180, 180, 200];

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
        ColoredBox(
          color: context.colorScheme.surfaceContainer,
          child: Row(
            children: [
              'Name'.txt.size(width: _columnSizes[0]),
              'Description'.txt.expand(),
              if (!smallScreen) 'Tags'.txt.size(width: _columnSizes[1]),
              'Created At'.txt.size(width: _columnSizes[2]),
              if (largeScreen) 'Hash'.txt.size(width: _columnSizes[3]),
              'Actions'.txt.size(width: _columnSizes[4]),
            ],
          ).padByUnits(1, 1, 1, 1),
        ),
        ListView.separated(
          separatorBuilder: (context, index) => Divider(height: 1),
          itemCount: useCases.cases.length,
          itemBuilder: (context, index) {
            final uc = useCases.cases[index];
            return TableItem(
                useCase: uc,
                largeScreen: largeScreen,
                smallScreen: smallScreen);
          },
        ).expand(),
      ],
    );
  }
}

class TableItem extends StatefulWidget {
  const TableItem({
    super.key,
    required this.useCase,
    required this.largeScreen,
    required this.smallScreen,
    this.onTap,
  });

  final UseCase useCase;
  final bool largeScreen;
  final bool smallScreen;
  final GestureTapCallback? onTap;

  @override
  State<TableItem> createState() => TableItemState();
}

class TableItemState extends State<TableItem> {
  bool _onOver = false;

  @override
  Widget build(BuildContext context) {
    final useCase = widget.useCase;
    return Consumer(
      builder: (context, ref, _) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) {
          if (!mounted) return;
          setState(() {
            _onOver = true;
          });
        },
        onExit: (e) {
          if (!mounted) return;
          setState(() {
            _onOver = false;
          });
        },
        child: InkWell(
          onTap: () => context.push('/edit_usecase/${useCase.id}'),
          child: ColoredBox(
            color: _onOver
                ? context.colorScheme.surfaceContainer
                : Colors.transparent,
            child: Row(
              key: ValueKey(useCase.id ?? useCase.generateHash()),
              children: [
                Icon(
                  Icons.file_open_rounded,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                HGap.units(2),
                useCase.name.txt.size(width: _columnSizes[0]),
                (useCase.description ?? '').txt.expand(),
                if (!widget.smallScreen)
                  UseCaseTags(useCase: useCase).size(width: _columnSizes[1]),
                DateFormat.Hm()
                    .add_yMd()
                    .format(useCase.createdAt)
                    .txt
                    .size(width: _columnSizes[2]),
                if (widget.largeScreen)
                  useCase.generateHash().txt.size(width: _columnSizes[3]),
                [
                  SecondaryButton(
                      icon: Icons.edit,
                      description: 'Edit Use Case Details',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => UseCaseDialog(
                            title: 'Edit UseCases Details',
                            value: useCase,
                            onConfirm: (details) {
                              ref
                                  .read(useCasesNotifierProvider.notifier)
                                  .updateUseCase(useCase.copyWith(
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
                        ref.read(useCaseExporterProvider).export(useCase);
                      }),
                  SecondaryButton(
                      icon: Icons.copy,
                      description: 'Duplicate Use Case',
                      onPressed: () {
                        ref
                            .read(useCasesNotifierProvider.notifier)
                            .addUseCase(useCase.duplicate());
                      }),
                  SecondaryButton(
                      icon: Icons.delete,
                      confirming: true,
                      description: 'Delete Use Case',
                      onPressed: () {
                        ref
                            .read(useCasesNotifierProvider.notifier)
                            .deleteUseCase(useCase);
                      }),
                ].row().size(width: _columnSizes[4]),
                // ref
                //   .read(useCasesNotifierProvider.notifier)
                //  .setSelected(index);
                HGap.units(2),
              ],
            ),
          ),
        ),
      ),
    );
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
