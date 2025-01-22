/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/section_title.dart';
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
          itemBuilder: (context, i) => ListTile(
            dense: true,
            title: sections[i].$1.substringAfter(':').trim().txt,
            onTap: () {
              onSelect(i, sections[i].$1);
            },
          ),
        ).expand(),
      ],
    );
  }
}
