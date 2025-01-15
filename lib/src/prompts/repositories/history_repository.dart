/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'history_repository.g.dart';

//
// Repository for storing and fetching the prompt history.
//
class HistoryRepository {
  HistoryRepository(this._sharedPreferences);

  final _promptHistoryKey = 'prompt_history';
  final SharedPreferences _sharedPreferences;

  List<String> fetch() {
    return _sharedPreferences.getStringList(_promptHistoryKey) ?? List.empty();
  }

  store(List<String> history) {
    _sharedPreferences.setStringList(_promptHistoryKey, history);
  }
}

@riverpod
HistoryRepository historyRepository(HistoryRepositoryRef ref) {
  return HistoryRepository(ref.watch(sharedPreferencesProvider));
}
