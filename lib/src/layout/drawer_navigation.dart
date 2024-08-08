import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arc_view/src/routes.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: navigation
            .map(
              (e) => ListTile(
                leading: Icon(e.icon),
                title: Text(e.title),
                onTap: () {
                  context.go(e.route);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
