import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'prompt_history.g.dart';

@Riverpod(keepAlive: true)
class PromptHistory extends _$PromptHistory {
  final _promptHistoryKey = 'prompt_history';
  late SharedPreferences _sharedPreferences;

  @override
  Future<List<String>> build() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    //return _sharedPreferences.getStringList(_promptHistoryKey) ?? List.empty();
    return List.empty();
  }

  add(String prompt) {
    final oldState = state.valueOrNull;
    final List<String> newState;

    if (prompt.isEmpty) return;

    if (oldState != null) {
      if (oldState.contains(prompt)) return;
      if (oldState.length > 15) oldState.removeLast();
      newState = [prompt, ...oldState];
      //_sharedPreferences.setStringList(_promptHistoryKey, newState);
    } else {
      newState = [prompt];
    }
    state = AsyncData(newState);
  }
}

@riverpod
class CurrentPromptController extends _$CurrentPromptController {
  var _promptIndex = 0;

  @override
  String build() => '';

  clear() {
    state = '';
  }

  rotate() {
    final history = ref.read(promptHistoryProvider).valueOrNull;
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
