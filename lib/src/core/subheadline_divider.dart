/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:arc_view/src/core/extensions.dart';

class SubheadlineDivider extends StatelessWidget {
  const SubheadlineDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 2,
      color: context.colorScheme.primary,
      indent: 8,
      endIndent: 18,
      thickness: 1,
    );
  }
}
