import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arc_view/src/core/extensions.dart';
import 'package:arc_view/src/routes.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      extended: MediaQuery.of(context).size.width > 900,
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      elevation: 4,
      minExtendedWidth: 180,
      leading: 'OneAI'.h1.padding(),
      destinations: navigation
          .map(
            (e) => NavigationRailDestination(
                icon: Icon(e.icon), label: Text(e.title)),
          )
          .toList(),
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        context.go(navigation[index].route);
      },
    );
  }
}

class NavigationItem {
  NavigationItem({
    required this.title,
    required this.route,
    required this.icon,
  });

  final String title;
  final String route;
  final IconData icon;
}
