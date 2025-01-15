/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
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
        fontSize: 10.0,
        color: Colors.white.withOpacity(0.6),
      ),
      bodyMedium: TextStyle(fontSize: 12.0),
      bodyLarge: TextStyle(fontSize: 14.0),
      titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 14.0),
      titleMedium: TextStyle(fontSize: 16.0),
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
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278216822),
      surfaceTint: Color(4278216822),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4288737279),
      onPrimaryContainer: Color(4278198053),
      secondary: Color(4283064935),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4291684333),
      onSecondaryContainer: Color(4278525731),
      tertiary: Color(4283719038),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4292600319),
      onTertiaryContainer: Color(4279245367),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294310652),
      onSurface: Color(4279704862),
      onSurfaceVariant: Color(4282337354),
      outline: Color(4285495675),
      outlineVariant: Color(4290758858),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020723),
      inversePrimary: Color(4286764003),
      primaryFixed: Color(4288737279),
      onPrimaryFixed: Color(4278198053),
      primaryFixedDim: Color(4286764003),
      onPrimaryFixedVariant: Color(4278210137),
      secondaryFixed: Color(4291684333),
      onSecondaryFixed: Color(4278525731),
      secondaryFixedDim: Color(4289842129),
      onSecondaryFixedVariant: Color(4281551695),
      tertiaryFixed: Color(4292600319),
      onTertiaryFixed: Color(4279245367),
      tertiaryFixedDim: Color(4290561515),
      onTertiaryFixedVariant: Color(4282140261),
      surfaceDim: Color(4292205532),
      surfaceBright: Color(4294310652),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916150),
      surfaceContainer: Color(4293521392),
      surfaceContainerHigh: Color(4293126635),
      surfaceContainerHighest: Color(4292797413),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black.withOpacity(0.5),
      unselectedLabelColor: Colors.black.withOpacity(0.5),
      labelPadding: const EdgeInsets.all(0),
      indicatorColor: Colors.black.withOpacity(0.5),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(fontSize: 10.0),
      bodyMedium: TextStyle(fontSize: 12.0),
      bodyLarge: TextStyle(fontSize: 14.0),
      titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 14.0),
      titleMedium: TextStyle(fontSize: 16.0),
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
