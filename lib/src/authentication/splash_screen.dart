/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:arc_view/src/authentication/service/oidc_desktop_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'util/auth_util.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initCheck();
    });
  }

  Future<void> _initCheck() async {
    if (checkOidcAndNavigate(
        context, (value) => setState(() => _isLoading = value))) {
      return;
    }

    try {
      final desktopService = ref.read(oidcDesktopServiceProvider);
      final tokens = await desktopService.getStoredToken();
      bool navigateToHomeFlag = false;

      //1. check valid access-token if yes then go home
      if (isValidAccessToken(tokens)) {
        navigateToHomeFlag = true;
      }

      //2. try refresh token if yes then go home
      if (shouldTryRefresh(tokens)) {
        final refreshedTokens =
            await desktopService.tryRefresh(tokens!.refreshToken!);
        if (refreshedTokens != null) {
          await desktopService.saveToken(refreshedTokens);
          navigateToHomeFlag = true;
        }
      }
      // 3. Perform navigation
      if (!mounted) return;

      navigateToHomeFlag
          ? navigateToHome(
              context, (value) => setState(() => _isLoading = value))
          : navigateToLogin(
              context, (value) => setState(() => _isLoading = value));
    } catch (e) {
      // If any exception occurs, disable loading and show error or direct to login
      handleError(context, (value) => setState(() => _isLoading = value), e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      // Simple fallback UI if something fails
      return Scaffold(
        body: Center(
            child: Text(_error!, style: const TextStyle(color: Colors.red))),
      );
    }

    // Show loader while checking tokens
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : const Text('Redirecting...'),
      ),
    );
  }
}
