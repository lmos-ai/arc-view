/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/prompts/notifiers/prompt_history_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_prompt_notifier.g.dart';

@riverpod
class CurrentPromptNotifier extends _$CurrentPromptNotifier {
  var _promptIndex = 0;

  @override
  String build() => '';

  clear() {
    state = '';
  }

  setPrompt(String prompt) {
    state = prompt;
  }

  rotate() {
    final history = ref.read(promptHistoryNotifierProvider).valueOrNull;
    if (history == null || history.isEmpty) return;

    if (_promptIndex < 0) {
      _promptIndex = history.length - 1;
    } else if (_promptIndex >= history.length - 1) {
      _promptIndex = 0;
    } else {
      _promptIndex++;
    }
    state = history[_promptIndex];
  }
}
