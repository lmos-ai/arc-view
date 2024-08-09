import 'package:arc_view/src/chat/models/chat_message.dart';
import 'package:arc_view/src/chat/models/conversation.dart';
import 'package:arc_view/src/client/oneai_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  @override
  Conversation build() {
    return Conversation(
      messages: List.empty(),
      conversationId: 'conversationId-${DateTime.now().millisecondsSinceEpoch}',
    );
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
