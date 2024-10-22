/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/toolbar/agent_tabs.dart';
import 'package:arc_view/src/conversation/services/conversation_exporter.dart';
import 'package:arc_view/src/conversation/services/conversation_importer.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smiles/smiles.dart';

class ToolBar extends ConsumerWidget {
  const ToolBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const AgentTabs().padByUnits(0, 0, 0, 1).expand(),
        SecondaryButton(
          description: 'Show Settings',
          onPressed: () {
            context.push("/settings");
          },
          icon: Icons.settings,
        ),
        SecondaryButton(
          description: 'Import Conversation',
          onPressed: () {
            ref.read(conversationImporterProvider).load();
          },
          icon: Icons.upload,
        ),
        SecondaryButton(
          description: 'Export Conversation',
          onPressed: () {
            ref.read(conversationExporterProvider).export();
          },
          icon: Icons.download,
        ),
      ],
    );
  }
}
