/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/chat_screen.dart';
import 'package:arc_view/src/layout/main_layout.dart';
import 'package:arc_view/src/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arc_view/src/conversation/language_preference.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _mainNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'mainNav');

/// Main Routing
final appRoutes =
GoRouter(initialLocation: '/', navigatorKey: _rootNavigatorKey, routes: [
  ShellRoute(
    navigatorKey: _mainNavigatorKey,
    builder: (context, state, child) {
      return MainLayout(selectedIndex: 0, child: child); // TODO
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LanguagePreferenceScreen(),
      ),
      GoRoute(
          path: '/chat',
          builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  ),
]);
