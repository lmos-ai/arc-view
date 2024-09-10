/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main.g.dart';

late SharedPreferences preferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  String? languageCode = preferences.getString('selectedLanguage') ?? 'en'; //default is english
  runApp(ProviderScope(child: MessagingApp(languageCode: languageCode)));
}

@riverpod
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  return preferences;
}
