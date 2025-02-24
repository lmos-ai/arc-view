/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/tools/new_tool_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToolButton extends ConsumerWidget {
  const AddToolButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        _newTestTool(context, ref);
      },
    );
  }

  _newTestTool(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => NewToolDialog(),
    );
  }
}
