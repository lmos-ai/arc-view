/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/prompts/repositories/history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prompt_history_notifier.g.dart';

///
/// Notifier for the prompt history.
///
@Riverpod(keepAlive: true)
class PromptHistoryNotifier extends _$PromptHistoryNotifier {
  @override
  Future<List<String>> build() async {
    return ref.read(historyRepositoryProvider).fetch();
  }

  add(String prompt) {
    final oldState = state.valueOrNull;
    final List<String> newState;

    if (prompt.isEmpty) return;

    if (oldState != null) {
      if (oldState.contains(prompt)) return;
      if (oldState.length > 15) oldState.removeLast();
      newState = [prompt, ...oldState];
      ref.read(historyRepositoryProvider).store(newState);
    } else {
      newState = [prompt];
    }
    state = AsyncData(newState);
  }

  remove(String prompt) async {
    final oldState = state.valueOrNull;

    if (oldState == null) return;
    final List<String> newState = [];
    for (var p in oldState) {
      if (p != prompt) {
        newState.add(p);
      }
    }
    state = AsyncData(newState);
    ref.read(historyRepositoryProvider).store(newState);
  }
}
