/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/toolbar/agent_tabs.dart';
import 'package:arc_view/src/conversation/conversation_exporter.dart';
import 'package:arc_view/src/conversation/conversation_importer.dart';
import 'package:arc_view/src/core/extensions.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ToolBar extends ConsumerWidget {
  const ToolBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        const AgentTabs().pad(0, 0, 0, 8).expand(),
        SecondaryButton(
          onPressed: () {
            context.push("/settings");
          },
          icon: Icons.settings,
        ),
        SecondaryButton(
          onPressed: () {
            ref.read(conversationImporterProvider).load();
          },
          icon: Icons.upload,
        ),
        SecondaryButton(
          onPressed: () {
            ref.read(conversationExporterProvider).export();
          },
          icon: Icons.download,
        ),
      ],
    );
  }
}
