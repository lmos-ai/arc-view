/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';

class ActionEvent extends StatelessWidget {
  const ActionEvent({
    super.key,
    required this.name,
    this.success,
  });

  final String name;
  final bool? success;

  @override
  Widget build(BuildContext context) {
    return [
      if (success != true) Icon(Icons.warning, color: Colors.red, size: 12),
      if (success == true) Icon(Icons.check, color: Colors.green, size: 12),
      name.txt.padByUnits(0, 0, 0, 2),
    ].row(min: true);
  }
}
