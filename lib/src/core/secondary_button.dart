/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:flutter/material.dart';
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
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String description;
  final Color? color;
  final bool? enabled;
  final IconData? disabledIcon;

  @override
  Widget build(BuildContext context) {
    var applyColor = color ?? Theme.of(context).colorScheme.onSurface;

    if (enabled == false) {
      applyColor = applyColor.withValues(alpha: 0.3);
    }

    return IconButton(
      onPressed: enabled == false ? null : onPressed,
      icon: Icon(
        enabled == false ? disabledIcon ?? icon : icon,
        size: 16,
        color: applyColor,
      ),
    ).tip(description);
  }
}
