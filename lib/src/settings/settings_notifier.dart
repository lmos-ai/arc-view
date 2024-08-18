import 'dart:convert';

import 'package:arc_view/src/client/system_context.dart';
import 'package:arc_view/src/client/user_context.dart';
import 'package:arc_view/src/conversation/conversation_notifier.dart';
import 'package:arc_view/src/settings/settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_notifier.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Settings build() {
    return Settings(
      changed: false,
      newUserContext: null,
      newSystemContext: null,
    );
  }

  updateChanged() {
    state = state.copyWith(changed: true);
  }

  updateUserContext(String newUserContext) {
    state = state.copyWith(changed: true, newUserContext: newUserContext);
  }

  updateSystemContext(String newSystemContext) {
    state = state.copyWith(changed: true, newSystemContext: newSystemContext);
  }

  commit() {
    final conversation = ref.read(conversationNotifierProvider);

    final updatedConversation = conversation.copyWith(
      userContext: state.newUserContext == null
          ? conversation.userContext
          : UserContext.fromJson(jsonDecode(state.newUserContext!)),
      systemContext: state.newSystemContext == null
          ? conversation.systemContext
          : SystemContext.fromJson(jsonDecode(state.newSystemContext!)),
    );

    state = state.copyWith(changed: false);
    ref
        .read(conversationNotifierProvider.notifier)
        .updateConversation(updatedConversation);
  }
}

extension SettingsRef on WidgetRef {
  commitSettings() {
    read(settingsNotifierProvider.notifier).commit();
  }

  bool watchSettingsChanged() {
    return watch(settingsNotifierProvider.select((s) => s.changed));
  }
}
