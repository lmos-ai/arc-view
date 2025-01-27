/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/hoverable_list_tile.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/core/section_title.dart';
import 'package:arc_view/src/usecases/edit_usecase_dialog.dart';
import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class UseCaseSectionList extends ConsumerWidget {
  const UseCaseSectionList({
    super.key,
    required this.sections,
    required this.onSelect,
  });

  final List<(String, String)> sections;
  final void Function(int, String) onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(text: 'Overview').padByUnits(0, 0, 0, 2),
        VGap(),
        ListView.builder(
          itemCount: sections.length,
          itemBuilder: (context, i) => HoverableListTile(
            title: sections[i].$1.substringAfter(':').trim().txt,
            onTap: () {
              onSelect(i, sections[i].$1);
            },
            buttons: [
              SecondaryButton(
                icon: Icons.edit,
                description: 'Edit Use Case',
                onPressed: () {
                  showEditUseCaseDialog(context, i, sections, ref);
                },
              ),
              SecondaryButton(
                icon: Icons.delete,
                confirming: true,
                description: 'Delete Use Case',
                onPressed: () {
                  _deleteUseCase(sections, i, ref);
                },
              ),
            ],
          ),
        ).padByUnits(0, 0, 1, 1).expand(),
      ],
    );
  }

  _deleteUseCase(
    List<(String, String)> sections,
    int sectionIndex,
    WidgetRef ref,
  ) {
    var newText = '';
    for (var i = 0; i < sections.length; i++) {
      if (i != sectionIndex) {
        newText += '${sections[i].$2}\n';
      }
    }
    ref.read(useCasesNotifierProvider.notifier).updateSelected(newText);
  }
}
