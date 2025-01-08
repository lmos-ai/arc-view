/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smiles/smiles.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.child});

  final Widget child;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          NavigationRail(
            backgroundColor: context.colorScheme.surfaceContainer,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              _selectedIndex = index;
              switch (index) {
                case 0:
                  GoRouter.of(context).go('/');
                  break;
                case 1:
                  GoRouter.of(context).go('/usecases');
                  break;
                case 2:
                  GoRouter.of(context).go('/settings');
                  break;
              }
            },
            minWidth: 60,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.chat_outlined, size: 16),
                label: SmallText('Chat'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book_rounded, size: 16),
                label: SmallText('Use Cases'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings, size: 16),
                label: SmallText('Settings'),
              ),
            ],
          ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
