/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:async';

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CopyToClipboardButton extends StatefulWidget {
  const CopyToClipboardButton({super.key, required this.textProvider});

  final String Function() textProvider;

  @override
  State<CopyToClipboardButton> createState() => _CopyToClipboardButtonState();
}

class _CopyToClipboardButtonState extends State<CopyToClipboardButton> {
  var _icon = Icons.copy;

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      icon: _icon,
      description: 'Copy to Clipboard',
      onPressed: () {
        setState(() {
          _icon = Icons.done;
        });
        Clipboard.setData(
          ClipboardData(text: widget.textProvider()),
        ).then((_) {});
        Timer(1.seconds, () {
          if (!mounted) return;
          setState(() {
            _icon = Icons.copy;
          });
        });
      },
    );
  }
}
