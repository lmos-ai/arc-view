/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/agent_client_notifier.dart';
import 'package:arc_view/src/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/app_localization.dart';

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
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)
                    .translate('AgentUrlKey'),
                isDense: true, // Added this
              ),
              onChanged: (value) {
                ref.read(agentClientNotifierProvider.notifier).setUrl(value);
              },
            ).expand(),
          ],
        ),
      );
    });
  }
}
