import 'package:arc_view/src/client/oneai_client.dart';
import 'package:arc_view/src/conversation/chat_message.dart';
import 'package:arc_view/src/conversation/conversation_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation.g.dart';

@riverpod
class Conversation extends _$Conversation {
  @override
  ConversationData build() {
    return ConversationData(
      messages: List.empty(),
      conversationId: 'conversationId-${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  load(ConversationData conversation) {
    state = conversation;
  }

  addUserChat(String msg) {
    addChat(ChatMessage(
      type: MessageType.user,
      content: msg,
      conversationId: state.conversationId,
    ));
  }

  clear() {
    state = build();
  }

  addChat(ChatMessage msg) async {
    state = state.copyWith(messages: [
      ...state.messages,
      msg,
      ChatMessage(
        type: MessageType.loading,
        content: '',
        conversationId: state.conversationId,
      )
    ]);
    ref.read(oneAIClientProvider).sendMessage(state.messages).listen((value) {
      final newMessages = [];
      for (final message in state.messages) {
        if (message.type != MessageType.loading) {
          newMessages.add(message);
        }
      }
      state = state.copyWith(messages: [
        ...newMessages,
        ChatMessage(
          type: MessageType.bot,
          content: value,
          conversationId: state.conversationId,
        )
      ]);
    });
  }
}
