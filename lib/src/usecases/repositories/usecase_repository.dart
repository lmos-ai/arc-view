/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/main.dart';
import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'usecase_repository.g.dart';

@riverpod
UseCaseRepository useCaseRepository(Ref ref) {
  final preferences = ref.read(sharedPreferencesProvider);
  return UseCaseRepository(preferences);
}

///
/// Repository for loading and saving usecases.
///
class UseCaseRepository {
  UseCaseRepository(this._preferences);

  final SharedPreferences _preferences;

  List<UseCase> loadUseCases() {
    final useCases = _preferences.getStringList('usecases')?.map((e) {
      return UseCase.fromJson(jsonDecode(e));
    }).toList();
    return useCases ?? List.empty();
  }

  save(UseCases useCases) {
    _preferences.setStringList(
      'usecases',
      useCases.cases.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}
