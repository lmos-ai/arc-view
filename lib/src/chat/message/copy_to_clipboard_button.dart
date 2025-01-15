/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyToClipBoardButton extends StatelessWidget {
  const CopyToClipBoardButton(this._text, {this.color, super.key});

  final String _text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.copy, size: 12, color: color),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: _text)).then((_) {
          //if (context.mounted) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text("Copied to clipboard")));
          // }
        });
      },
    );
  }
}
