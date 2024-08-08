import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout(
      {super.key, required this.child, required this.selectedIndex});

  final Widget child;
  final int selectedIndex;

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
