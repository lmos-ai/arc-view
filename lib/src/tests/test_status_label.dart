/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class TestStatusLabel extends ConsumerWidget {
  const TestStatusLabel({super.key, this.testName});

  final String? testName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return (testName != null ? 'Running test: $testName' : 'No Tests Running')
        .small;
  }
}
