import 'package:arc_view/src/client/oneai_client.dart';
import 'package:arc_view/src/client/system_context.dart';
import 'package:arc_view/src/client/user_context.dart';
import 'package:arc_view/src/conversation/conversation.dart';
import 'package:arc_view/src/conversation/conversation_message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversations.g.dart';

@riverpod
class Conversations extends _$Conversations {
  @override
  Conversation build() {
    return Conversation(
      userContext: UserContext(userId: "unknown"),
      systemContext: SystemContext(entries: []),
      messages: List.empty(),
      conversationId: 'conversationId-${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  updateConversation(Conversation conversation) {
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
