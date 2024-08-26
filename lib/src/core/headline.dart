/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:arc_view/src/core/extensions.dart';

class Headline extends StatelessWidget {
  const Headline(this.headline, {super.key});

  final String headline;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Text(
        headline,
        style: TextStyle(color: context.colorScheme.onSecondary),
      ),
    );
  }
}
