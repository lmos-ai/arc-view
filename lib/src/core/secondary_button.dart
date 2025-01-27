/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smiles/smiles.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.description,
    this.color,
    this.enabled,
    this.disabledIcon,
    this.confirming,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String description;
  final Color? color;
  final bool? enabled;
  final IconData? disabledIcon;
  final bool? confirming;

  @override
  Widget build(BuildContext context) {
    var applyColor = color ?? Theme.of(context).colorScheme.onSurface;

    if (enabled == false) {
      applyColor = applyColor.withValues(alpha: 0.3);
    }

    return (confirming == true && enabled != false
            ? _FeedBackButton(
                onPressed: onPressed,
                icon: Icon(icon, size: 16, color: applyColor),
              )
            : IconButton(
                onPressed: enabled == false ? null : onPressed,
                icon: Icon(
                  enabled == false ? disabledIcon ?? icon : icon,
                  size: 16,
                  color: applyColor,
                ),
              ))
        .tip(description);
  }
}

///
/// A bi
///
class _FeedBackButton extends StatefulWidget {
  const _FeedBackButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final Icon icon;

  @override
  State<_FeedBackButton> createState() => _FeedBackButtonState();
}

class _FeedBackButtonState extends State<_FeedBackButton> {
  bool _isConfirming = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (_isConfirming) {
          widget.onPressed();
        }
        setState(() {
          _isConfirming = true;
        });
        Timer(3.seconds, () {
          if (!mounted) return;
          setState(() {
            _isConfirming = false;
          });
        });
      },
      icon: _isConfirming
          ? Icon(Icons.question_mark, size: 16, color: Colors.amber)
          : widget.icon,
    );
  }
}
