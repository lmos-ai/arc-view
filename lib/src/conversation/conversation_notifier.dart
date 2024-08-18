import 'dart:convert';

import 'package:arc_view/main.dart';
import 'package:arc_view/src/client/oneai_client.dart';
import 'package:arc_view/src/client/system_context.dart';
import 'package:arc_view/src/client/user_context.dart';
import 'package:arc_view/src/conversation/conversation.dart';
import 'package:arc_view/src/conversation/conversation_message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_notifier.g.dart';

@riverpod
class ConversationNotifier extends _$ConversationNotifier {
  @override
  Conversation build() {
    final userContext = _loadUserContext();
    final systemContext = _loadSystemContext();
    return Conversation(
      userContext: userContext,
      systemContext: systemContext,
      messages: List.empty(),
      conversationId: 'conversationId-${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  UserContext _loadUserContext() {
    final json = _load('conversation_user_context');
    if (json == null) return UserContext(userId: "unknown", profile: []);
    return UserContext.fromJson(jsonDecode(json));
  }

  SystemContext _loadSystemContext() {
    final json = _load('conversation_system_context');
    if (json == null) return SystemContext(entries: []);
    return SystemContext.fromJson(jsonDecode(json));
  }

  String? _load(String key) =>
      ref.read(sharedPreferencesProvider).getString(key);

  updateConversation(Conversation conversation) {
    final preferences = ref.read(sharedPreferencesProvider);
    preferences.setString('conversation_user_context',
        jsonEncode(conversation.userContext.toJson()));
    preferences.setString('conversation_system_context',
        jsonEncode(conversation.systemContext.toJson()));
    state = conversation;
  }

  addUserMessage(String msg) {
    addMessage(ConversationMessage(
      type: MessageType.user,
      content: msg,
      conversationId: state.conversationId,
    ));
  }

  clear() {
    state = build();
  }

  addMessage(ConversationMessage msg) async {
    state = state.copyWith(messages: [
      ...state.messages,
      msg,
      ConversationMessage(
        type: MessageType.loading,
        content: '',
        conversationId: state.conversationId,
      )
    ]);
    ref.read(oneAIClientProvider).sendMessage(state).listen((value) {
      final newMessages = [];
      for (final message in state.messages) {
        if (message.type != MessageType.loading) {
          newMessages.add(message);
        }
      }
      state = state.copyWith(messages: [
        ...newMessages,
        ConversationMessage(
          type: MessageType.bot,
          content: value,
          conversationId: state.conversationId,
        )
      ]);
    });
  }
}
