/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/routes.dart';
import 'package:arc_view/src/theme_notifier.dart';
import 'package:arc_view/src/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagingApp extends ConsumerWidget {
  const MessagingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRoutes = createRouter(ref);
    return MaterialApp.router(
      title: 'Arc View',
      routerConfig: appRoutes,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ref.watch(themeNotifierProvider),
    );
  }
}
