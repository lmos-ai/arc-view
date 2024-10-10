/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/address_bar.dart';
import 'package:arc_view/src/chat/chat_panel.dart';
import 'package:arc_view/src/chat/toolbar/tool_bar.dart';
import 'package:arc_view/src/events/agent_events_notifier.dart';
import 'package:arc_view/src/core/extensions.dart';
import 'package:arc_view/src/core/gaps.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/events/events_list.dart';
import 'package:arc_view/src/layout/adaptive_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsPanel extends ConsumerWidget {
  const EventsPanel({super.key, this.width = 300});

  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SecondaryButton(
              onPressed: () {
                ref.read(agentEventsNotifierProvider.notifier).reset();
              },
              icon: Icons.refresh,
            ).toRight(),
            EventsList().expand()
          ],
        ),
      ),
    );
  }
}
