/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';

class PromptView extends StatelessWidget {
  const PromptView(this.prompt, {super.key});

  final String prompt;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Row(
        children: [
          'System Prompt'.txt.expand(),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: context.colorScheme.onSurface,
              )),
        ],
      ),
      children: [prompt.txt.padByUnits(3, 3, 3, 3)],
    );
  }
}
