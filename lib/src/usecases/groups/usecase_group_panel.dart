/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smiles/smiles.dart';

class UseCaseGroupPanel extends StatelessWidget {
  const UseCaseGroupPanel({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: name.h3,
        subtitle: 'Contains 7 use cases'.txt,
      ),
    ).size(height: 100, width: 300).animate().moveY(begin: 50).fadeIn();
  }
}
