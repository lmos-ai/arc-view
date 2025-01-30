/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'dart:math';

import 'package:arc_view/src/authentication/model/tokens.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../config_loader.dart';

/**
 * Token Specific functions
 * */

/// Check token expire
bool isTokenExpired(int? expiresAtMs) {
  if (expiresAtMs == null) return true;
  final nowMs = DateTime.now().millisecondsSinceEpoch;
  // You might leave a small buffer, e.g., 30 seconds, to avoid edge cases
  return nowMs >= (expiresAtMs - 30 * 1000);
}

/// Checks if the access token is valid and not expired
bool isValidAccessToken(Tokens? tokens) {
  return tokens?.accessToken?.isNotEmpty == true &&
      !isTokenExpired(tokens?.expiresAt);
}

/// Determines if a refresh attempt should be made
bool shouldTryRefresh(Tokens? tokens) {
  return tokens?.refreshToken?.isNotEmpty == true &&
      isTokenExpired(tokens?.expiresAt);
}

/**
 * General specific functions
 * */

/// Generate random state hash value
String generateRandomState(int length) {
  const characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random.secure();
  final randomState = List.generate(
      length, (index) => characters[random.nextInt(characters.length)]).join();
  return randomState;
}

/// Handles OIDC check and navigates accordingly
bool checkOidcAndNavigate(BuildContext context, Function setLoading) {
  final oidcEnabled = Config.get("openid.enabled", defaultValue: false);
  if (!oidcEnabled) {
    navigateToHome(context, setLoading);
    return true;
  }
  return false;
}

///Handle Error
void handleError(BuildContext context, Function setLoading, dynamic error) {
  debugPrint('Error at Splash Screen: $error');
  setLoading(false);
  if (context.mounted) {
    context.go('/login');
  }
}

/**
 * Navigation specifics function
 * */

/// Navigates to the home screen
void navigateToHome(BuildContext context, Function setLoading) {
  setLoading(false);
  if (context.mounted) {
    context.go('/');
  }
}

/// Navigates to the login screen
void navigateToLogin(BuildContext context, Function setLoading) {
  setLoading(false);
  if (context.mounted) {
    context.go('/login');
  }
}
