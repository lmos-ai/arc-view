/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:arc_view/src/routes.dart';
import 'package:arc_view/src/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_localization.dart';

class MessagingApp extends StatelessWidget {
  final String languageCode;
  late Locale? _locale;

  MessagingApp({required this.languageCode, super.key});

  @override
  Widget build(BuildContext context) {
    _locale = Locale(languageCode);
    return MaterialApp.router(
      locale: _locale,
      supportedLocales: const[Locale('en'), Locale('de'), Locale('fr')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Messaging App',
      routerConfig: appRoutes,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
