/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/authentication/util/auth_util.dart';
import 'package:arc_view/src/core/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smiles/smiles.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../authentication/service/oidc_desktop_service.dart';
import '../config_loader.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.child, required this.index});

  final Widget child;
  final int index;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool _isLoading = false;

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    setState(() => _isLoading = true);
    try {
      final desktopService = ref.read(oidcDesktopServiceProvider);
      await desktopService.logout();
      if (!mounted) return;
      navigateToLogin(context, (value) => setState(() => _isLoading = value));
    } catch (e) {
      if (!mounted) return;
      debugPrint("Logout error: $e");
      navigateToLogin(context, (value) => setState(() => _isLoading = value));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          NavigationRail(
            backgroundColor: context.colorScheme.surfaceContainer,
            selectedIndex: widget.index,
            onDestinationSelected: (int index) {
              switch (index) {
                case 0:
                  GoRouter.of(context).go('/');
                  break;
                case 1:
                  GoRouter.of(context).go('/chat');
                  break;
                case 2:
                  GoRouter.of(context).go('/usecases');
                  break;
                case 3:
                  GoRouter.of(context).go('/charts');
                  break;
                case 4:
                  GoRouter.of(context).go('/settings');
                  break;
              }
            },
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, child) {
                    final oidcEnabled = Config.get("openid.enabled", defaultValue: false);
                    if (!oidcEnabled) return SizedBox.shrink();
                    return IconButton(
                        icon: _isLoading
                            ? CircularProgressIndicator()
                            : Icon(Icons.logout, color: Colors.red),
                        onPressed: () => _handleLogout(context, ref));
                  },
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    launchUrlString('https://eclipse.dev/lmos/');
                  },
                  child: SvgPicture.asset(
                    'assets/lmos.svg',
                    semanticsLabel: 'Lmos Logo',
                    width: 30,
                  ).padByUnits(0, 0, 2, 0),
                )
              ],
            ).expand(),
            minWidth: 60,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home, size: 16),
                label: SmallText('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.chat_outlined, size: 16),
                label: SmallText('Chat'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book_rounded, size: 16),
                label: SmallText('Use Cases'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bar_chart_sharp, size: 16),
                label: SmallText('Charts'),
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
