/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:arc_view/src/authentication/util/auth_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../config_loader.dart';
import 'service/oidc_desktop_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;
  String? _errorMessage;
  final oidcName = Config.get("openid.type", defaultValue: false);

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
    // Recheck again just for the defensive approach, If OIDC is disabled, just go home
    if (checkOidcAndNavigate(
        context, (value) => setState(() => _isLoading = value))) {
      return;
    }
    try {
      final desktopService = ref.read(oidcDesktopServiceProvider);
      _setLoadingState(true); // Enable loader
      final bool success = await desktopService.login();
      if (!mounted) return;
      if (success) {
        navigateToHome(context, (value) => setState(() => _isLoading = value));
      } else {
        _handleLoginError('Login failed or was cancelled.');
      }
    } catch (e) {
      _handleLoginError('Login error: $e');
    }
  }

  void _setLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
      if (isLoading) _errorMessage = null; // Clear errors when starting login
    });
  }

  Future<void> _handleLoginError(String errorMessage) async {
    if (!mounted) return; // Ensure widget is still active
    setState(() {
      _errorMessage = errorMessage;
      _isLoading = false;
    });
    await _showErrorDialog(errorMessage);
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
