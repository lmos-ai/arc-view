/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smiles/smiles.dart';

class HomePanel extends StatelessWidget {
  const HomePanel({
    super.key,
    required this.headline,
    required this.body,
    this.button,
  });

  final String headline;
  final List<Widget> body;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headline.h3,
          VGap.small(),
          ...body,
          Spacer(),
          if (button != null) button!.toRight(),
        ],
      ).padByUnits(2, 4, 4, 4),
    ).size(height: 220, width: 400).animate().moveY(begin: 50).fadeIn();
  }
}
