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
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String description;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 16,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    ).tip(description);
  }
}
