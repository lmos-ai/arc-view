/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/notifiers/agent_url_notifier.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/core/text_input_dialog.dart';
import 'package:arc_view/src/settings/notifiers/env_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class EnvWrap extends StatelessWidget {
  const EnvWrap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Wrap(
          runSpacing: 1,
          children: [
            Card(
              child: SecondaryButton(
                icon: Icons.add,
                description: 'Add and set new Agent Url',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => TextInputDialog(
                      title: 'New Agent Url',
                      hintText: 'https://myagent.com',
                      onConfirm: (newName) {
                        if (newName.isEmpty) return;
                        ref.addEnv(newName);
                      },
                    ),
                  );
                },
              ),
            ),
            ...ref.watch(envNotifierProvider).map((env) {
              return Card(
                child: [
                  env.onPressed(() {
                    ref.read(agentUrlNotifierProvider.notifier).setUrl(env);
                  }),
                  SecondaryButton(
                    icon: Icons.clear,
                    description: 'Delete $env as Favorite',
                    onPressed: () {
                      ref.removeEnv(env);
                    },
                  )
                ].row(min: true),
              );
            })
          ],
        ).padByUnits(0, 0, 0, 1);
      },
    );
  }
}
