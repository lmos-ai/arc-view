import 'package:arc_view/src/core/extensions.dart';
import 'package:arc_view/src/layout/drawer_navigation.dart';
import 'package:flutter/material.dart';

class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold(
      {super.key, this.appBar, required this.body, this.floatingActionButton});

  final AppBar? appBar;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: true,
      floatingActionButton: floatingActionButton,
      drawer: context.isMobile() ? const DrawerNavigation() : null,
      body: body,
    );
  }
}
