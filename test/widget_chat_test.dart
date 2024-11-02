/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Initial view', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MessagingApp()));

    expect(find.text('Send'), findsOneWidget);
  });
}
