/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:flutter/material.dart';

class VGap extends StatelessWidget {
  const VGap({super.key}) : factor = 2;
  const VGap.times(this.factor, {super.key});
  const VGap.large({super.key}) : factor = 32;
  const VGap.medium({super.key}) : factor = 12;
  const VGap.small({super.key}) : factor = 4;

  final int? factor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: (factor ?? 2) * 4);
  }
}

class HGap extends StatelessWidget {
  const HGap({super.key}) : factor = 2;
  const HGap.times(this.factor, {super.key});
  const HGap.large({super.key}) : factor = 32;
  const HGap.medium({super.key}) : factor = 12;
  const HGap.small({super.key}) : factor = 4;

  final int factor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: factor * 4);
  }
}
