/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:arc_view/main.dart';

import 'test_preferences.dart';

void main() {
  testWidgets('Initial view', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(TestPreferences()),
        ],
        child: MessagingApp(),
      ),
    );

    expect(find.text('Send'), findsOneWidget);
  });
}
