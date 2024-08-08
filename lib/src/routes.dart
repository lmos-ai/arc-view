import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arc_view/src/chat/chat_screen.dart';
import 'package:arc_view/src/layout/main_layout.dart';
import 'package:arc_view/src/layout/side_navigation.dart';

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
        builder: (context, state) => const ChatScreen(),
      ),
    ],
  ),
]);

/// Side Navigation
final navigation = [
  // NavigationItem(
  //   title: 'Agent Assistant', route: '/agent', icon: Icons.accessibility),
  NavigationItem(title: 'Chat', route: '/', icon: Icons.line_weight_sharp),
  NavigationItem(
      title: 'Prompts', route: '/prompts', icon: Icons.text_fields_outlined),
  NavigationItem(title: 'Settings', route: '/settings', icon: Icons.settings),
];
