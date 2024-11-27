/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';

///
/// Dark Theme
///
final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'RobotoMono',
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 1, 10, 11),
      onSurface: Colors.white.withOpacity(0.6),
      outline: Colors.white.withOpacity(0.2),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white.withOpacity(0.5),
      unselectedLabelColor: Colors.white.withOpacity(0.5),
      labelPadding: const EdgeInsets.all(0),
      indicatorColor: Colors.white.withOpacity(0.5),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 12.0,
        color: Colors.white.withOpacity(0.4),
      ),
    ),
    useMaterial3: true,
    pageTransitionsTheme: _pageTransitionsTheme,
    extensions: const [
      PaddingTheme(unit: 8),
      GapsTheme(unit: 4),
    ]);

///
/// Light Theme
///
///
final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'RobotoMono',
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color.fromARGB(255, 171, 0, 111),
      secondaryContainer: const Color.fromARGB(255, 247, 247, 248),
      onSurface: Colors.black.withOpacity(0.6),
      outline: Colors.black.withOpacity(0.2),
      //surface: Colors.blue
      //background: Colors.black,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black.withOpacity(0.5),
      unselectedLabelColor: Colors.black.withOpacity(0.5),
      labelPadding: const EdgeInsets.all(0),
      indicatorColor: Colors.black.withOpacity(0.5),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 12.0,
        color: Colors.black.withOpacity(0.4),
      ),
    ),
    useMaterial3: true,
    pageTransitionsTheme: _pageTransitionsTheme,
    extensions: const [
      PaddingTheme(unit: 8),
      GapsTheme(unit: 4),
    ]);

///
/// PageTransitionsTheme
///
const _pageTransitionsTheme = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.linux: _NoAnimationPageTransitionsBuilder(),
    TargetPlatform.macOS: _NoAnimationPageTransitionsBuilder(),
    TargetPlatform.windows: _NoAnimationPageTransitionsBuilder(),
  },
);

class _NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  const _NoAnimationPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
