/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          // if (!context.isMobile()) SideNavigation(selectedIndex: selectedIndex),
          Expanded(child: child),
        ],
      ),
    );
  }
}
