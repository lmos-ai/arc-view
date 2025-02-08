/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/tools/new_tool_dialog.dart';
import 'package:arc_view/src/tools/notifiers/selected_tool_notifier.dart';
import 'package:arc_view/src/tools/notifiers/tools_notifier.dart';
import 'package:arc_view/src/tools/services/tools_exporter.dart';
import 'package:arc_view/src/tools/services/tools_importer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class ToolsPanel extends ConsumerWidget {
  const ToolsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tools = ref.watch(toolsNotifierProvider);
    final selected = ref.watch(selectedToolNotifierProvider);

    return Card(
      margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SecondaryButton(
                description: 'Add Tool',
                icon: Icons.add,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => NewToolDialog(),
                  );
                },
              ),
              SecondaryButton(
                description: 'Import Tools',
                icon: Icons.upload,
                onPressed: () {
                  ref.read(toolsImporterProvider).importTool();
                },
              ),
            ],
          ),
          (tools.isEmpty)
              ? Center(child: 'Add a new tool.'.txt).expand()
              : ListView.builder(
                  itemCount: tools.length,
                  itemBuilder: (context, index) {
                    final tool = tools[index];
                    return ListTile(
                      leading: selected.contains(tool)
                          ? SecondaryButton(
                              color: context.colorScheme.primary,
                              icon: Icons.check,
                              description: 'DeSelect Tool',
                              onPressed: () {
                                ref
                                    .read(selectedToolNotifierProvider.notifier)
                                    .deselect(tool);
                              },
                            )
                          : SecondaryButton(
                              icon: Icons.check_box_outline_blank,
                              description: 'Select Tool',
                              onPressed: () {
                                ref
                                    .read(selectedToolNotifierProvider.notifier)
                                    .select(tool);
                              },
                            ),
                      title: tool.title.txt,
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tool.name.txt,
                          tool.description.txt,
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SecondaryButton(
                            description: 'Edit Tool',
                            icon: Icons.edit,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => NewToolDialog(tool: tool),
                              );
                            },
                          ),
                          HGap(),
                          SecondaryButton(
                            description: 'Download Tools',
                            enabled: tools.isNotEmpty,
                            onPressed: () {
                              ref.read(toolsExporterProvider).export(tool);
                            },
                            icon: Icons.download,
                          ),
                          HGap(),
                          SecondaryButton(
                            confirming: true,
                            description: 'Delete Tool',
                            icon: Icons.delete,
                            onPressed: () {
                              ref
                                  .read(toolsNotifierProvider.notifier)
                                  .removeTool(tool);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ).expand(),
        ],
      ),
    );
  }
}
