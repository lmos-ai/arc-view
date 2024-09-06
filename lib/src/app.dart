/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:arc_view/src/routes.dart';
import 'package:arc_view/src/themes.dart';

class MessagingApp extends StatelessWidget {
  const MessagingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Messaging App',
      routerConfig: appRoutes,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
