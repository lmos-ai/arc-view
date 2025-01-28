import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'service/auth_storage_service.dart';
import 'util/auth_util.dart';
import 'oidc_config.dart';

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
    _initCheck();
  }

  Future<void> _initCheck() async {
    if (!oidcEnabled) {
      // If OIDC is disabled in your config, go straight to home
      setState(() => _isLoading = false);
      if (mounted) context.go('/');
      return;
    }

    try {
      // 1. Read saved tokens from secure storage
      final (accessToken, refreshToken, expiresAtMs) =
          await AuthStorage.readTokens();
      final bool hasToken = (accessToken != null && accessToken.isNotEmpty);
      final bool expired = isTokenExpired(expiresAtMs);

      // 2. If valid token not expired, go home
      if (hasToken && !expired) {
        setState(() => _isLoading = false);
        if (mounted) context.go('/');
        return;
      }

      // 3. Attempt refresh if expired
      if (expired && refreshToken != null && refreshToken.isNotEmpty) {
        final refreshed = await tryRefresh(refreshToken);
        if (refreshed != null && refreshed.accessToken != null) {
          await AuthStorage.saveTokens(
            accessToken: refreshed.accessToken!,
            refreshToken: refreshed.refreshToken,
            expiresAtMs: refreshed.expiresAtMs!,
          );
          setState(() => _isLoading = false);
          if (mounted) context.go('/');
          return;
        }
      }

      // 4. Otherwise, go to /login
      setState(() => _isLoading = false);
      if (mounted) context.go('/login');
    } catch (e) {
      // If any exception occurs, disable loading and show error or direct to login
      setState(() {
        _error = 'Splash error: $e';
        _isLoading = false;
      });
      if (mounted) context.go('/login');
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
