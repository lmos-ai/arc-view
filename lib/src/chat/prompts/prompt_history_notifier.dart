import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'prompt_history_notifier.g.dart';

@Riverpod(keepAlive: true)
class PromptHistoryNotifier extends _$PromptHistoryNotifier {
  final _promptHistoryKey = 'prompt_history';
  late SharedPreferences _sharedPreferences;

  @override
  Future<List<String>> build() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getStringList(_promptHistoryKey) ?? List.empty();
  }

  add(String prompt) {
    final oldState = state.valueOrNull;
    final List<String> newState;

    if (prompt.isEmpty) return;

    if (oldState != null) {
      if (oldState.contains(prompt)) return;
      if (oldState.length > 15) oldState.removeLast();
      newState = [prompt, ...oldState];
      _sharedPreferences.setStringList(_promptHistoryKey, newState);
    } else {
      newState = [prompt];
    }
    state = AsyncData(newState);
  }

  remove(String prompt) async {
    final oldState = state.valueOrNull;

    if (oldState == null) return;
print(oldState);
    final List<String> newState = [];
    for (var p in oldState) {
      if (p != prompt) {
        newState.add(p);
      }
    }
    state = AsyncData(newState);
    _sharedPreferences.setStringList(_promptHistoryKey, newState);
  }
}

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
