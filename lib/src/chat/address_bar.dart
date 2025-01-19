/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/notifiers/agent_client_notifier.dart';
import 'package:arc_view/src/client/notifiers/agent_url_notifier.dart';
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
      final agentClient = ref.read(agentClientNotifierProvider);

      return Container(
        padding: const EdgeInsets.all(8),
        height: 64,
        width: double.infinity,
        child: Row(
          children: [
            TextField(
              controller: TextEditingController(
                  text: agentClient.agentUrl.url.toString()),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Agent Url',
                isDense: true, // Added this
              ),
              onChanged: (value) {
                ref.read(agentUrlNotifierProvider.notifier).setUrl(value);
              },
            ).expand(),
          ],
        ),
      );
    });
  }
}
