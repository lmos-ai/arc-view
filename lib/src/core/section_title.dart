/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme.onSurface;
    return [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff073a40),
        ),
      ),
      HGap.units(2),
      text.style(color: color),
    ].row(min: true);
  }
}
