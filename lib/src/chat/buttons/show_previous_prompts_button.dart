/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/prompts/prompt_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class PreviousPromptButton extends ConsumerWidget {
  const PreviousPromptButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        icon: Icon(
          Icons.line_weight_sharp,
          color: context.colorScheme.onSurface,
        ),
        onPressed: () {
          showPromptList(context);
        }).tip('Show previous prompts');
  }
}
