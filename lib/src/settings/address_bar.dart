/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/notifiers/agent_client_notifier.dart';
import 'package:arc_view/src/core/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class AddressBar extends StatefulWidget {
  const AddressBar({super.key});

  @override
  State<AddressBar> createState() => _AddressBarState();
}

class _AddressBarState extends State<AddressBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final agentClient = ref.watch(agentClientNotifierProvider);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(text: 'Agent Url').padByUnits(3, 1, 1, 1),
          Row(
            children: [
              Row(
                children: [
                  'Selected Agent Url: '.h3,
                  agentClient.agentUrl.url.toString().h3,
                ],
              ).padByUnits(1, 2, 1, 1),
            ],
          ),
        ],
      );
    });
  }
}
