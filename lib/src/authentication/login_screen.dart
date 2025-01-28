import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'oidc_config.dart';
import 'service/oidc_desktop_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;
  String? _errorMessage;
  final _desktopService = OidcDesktopService(
    issuerBase: issuerBase,
    clientId: clientId,
    clientSecret: clientSecret,
    redirectBaseUrl: redirectBaseUrl,
    scopes: scopes,
    callbackPath: callbackPath,
  );

  //Show Error Dialog
  Future<void> _showErrorDialog(String message) async {
    if (!mounted) return;
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogin() async {
    // Recheck again just for defensive approach, If OIDC is disabled, just go home
    if (!oidcEnabled) {
      context.go('/');
      return;
    }

    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      bool success;
      success = await _desktopService.login();
      if (success) {
        if (mounted) context.go('/');
      } else {
        // Show error and disable loader
        setState(() {
          _errorMessage = 'Login failed or was cancelled.';
          _isLoading = false;
        });
        await _showErrorDialog(_errorMessage!);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Login error: $e';
        _isLoading = false;
      });
      await _showErrorDialog(_errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sample "innovative" UI design with gradient background & brand logo
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF60a5fa), Color(0xFF34d399)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // 2. Main content card
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Brand Logo
                      ClipOval(
                        child: SvgPicture.asset(
                          'assets/lmos.svg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Welcome to the Arc View',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please sign in with ${oidcName?.toUpperCase() ?? 'OIDC'} to continue',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      // 3. Login button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
                                  'LOG IN VIA ${oidcName?.toUpperCase() ?? 'OIDC'}'),
                        ),
                      ),
                      // 4. Optional error text
                      if (_errorMessage != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
