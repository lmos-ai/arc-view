/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/core/section_title.dart';
import 'package:arc_view/src/tools/add_tool_button.dart';
import 'package:arc_view/src/tools/notifiers/selected_tool_notifier.dart';
import 'package:arc_view/src/tools/notifiers/tools_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

///
/// Main screen for managing test functions.
///
class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'Test Functions'.txt),
      floatingActionButton: AddToolButton(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child:
                'Defines your test functions here. They will be automatically added to your Agent.'
                    .txt
                    .padByUnits(2, 2, 2, 2),
          ).padByUnits(2, 2, 2, 1),
          SectionTitle(text: 'Tools').padByUnits(2, 2, 2, 2),
          Row(
            children: [
              Card(
                child: Consumer(builder: (context, ref, child) {
                  final tools = ref.watch(toolsNotifierProvider);
                  final selected = ref.watch(selectedToolNotifierProvider);
                  return ListView.builder(
                    itemCount: tools.length,
                    itemBuilder: (context, index) {
                      final tool = tools[index];
                      return ListTile(
                        leading: selected.contains(tool.id)
                            ? SecondaryButton(
                                color: context.colorScheme.primary,
                                icon: Icons.check,
                                description: 'DeSelect Tool',
                                onPressed: () {
                                  ref
                                      .read(
                                          selectedToolNotifierProvider.notifier)
                                      .deselect(tool);
                                },
                              )
                            : SecondaryButton(
                                icon: Icons.check_box_outline_blank,
                                description: 'Select Tool',
                                onPressed: () {
                                  ref
                                      .read(
                                          selectedToolNotifierProvider.notifier)
                                      .select(tool);
                                },
                              ),
                        title: tool.name.txt,
                        subtitle: tool.description.txt,
                        trailing: SecondaryButton(
                          description: 'Delete Tool',
                          icon: Icons.delete,
                          onPressed: () {
                            ref
                                .read(toolsNotifierProvider.notifier)
                                .removeTool(tool);
                          },
                        ),
                      );
                    },
                  );
                }),
              ).padByUnits(1, 1, 1, 1).max(width: 380),
              Card(
                child: Consumer(
                  builder: (context, ref, child) {
                    final tools = ref.watch(toolsNotifierProvider);
                    return 'hi'.txt;
                  },
                ),
              ).expand(),
            ],
          ).expand(),
        ],
      ),
    );
  }
}
