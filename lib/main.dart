/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main.g.dart';

late SharedPreferences preferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['RobotoMono'], license);
    final apache2 = await rootBundle.loadString('LICENSES/Apache-2.0.txt');
    yield LicenseEntryWithLineBreaks(['Arc View'], apache2);
  });

  runApp(const ProviderScope(child: MessagingApp()));
}

@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  return preferences;
}
