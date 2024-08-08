import 'package:flutter/material.dart';

///
/// Dark Theme
///
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'RobotoMono',
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 171, 0, 111),
  ),
  useMaterial3: true,
  pageTransitionsTheme: _pageTransitionsTheme,
);

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
    //surface: Colors.blue
    //background: Colors.black,
  ),
  useMaterial3: true,
  pageTransitionsTheme: _pageTransitionsTheme,
);

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
