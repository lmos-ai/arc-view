/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/chat_screen.dart';
import 'package:arc_view/src/events/events_screen.dart';
import 'package:arc_view/src/home/home_screen.dart';
import 'package:arc_view/src/layout/main_layout.dart';
import 'package:arc_view/src/metrics/charts_screen.dart';
import 'package:arc_view/src/settings/settings_screen.dart';
import 'package:arc_view/src/usecases/usecases_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'authentication/login_screen.dart';
import 'authentication/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _mainNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'mainNav');

/// Main Routing
final appRoutes = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true, //enable for testing and see logs
  navigatorKey: _rootNavigatorKey,
  routes: [
    // 1. Splash route
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(),
    ),
    // 2. Login route (outside the shell)
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),

    // 3. The ShellRoute for your main layout & tabs
    ShellRoute(
      navigatorKey: _mainNavigatorKey,
      builder: (context, state, child) {
        final index = switch (state.matchedLocation) {
          '/' => 0,
          '/chat' => 1,
          '/usecases' => 2,
          '/charts' => 3,
          '/settings' => 4,
          _ => 0,
        };
        return MainLayout(index: index, child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/chat',
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/usecases',
          builder: (context, state) => const UseCasesScreen(),
        ),
        GoRoute(
          path: '/events',
          builder: (context, state) => const EventsScreen(),
        ),
        GoRoute(
          path: '/charts',
          builder: (context, state) => const ChartsScreen(),
        ),
      ],
    ),
  ],
  // 4. Global redirect logic
  redirect: (context, state) {
    // Optionally do additional checks here,
    // but the splash logic alone might suffice.
    return null;
  },
);
