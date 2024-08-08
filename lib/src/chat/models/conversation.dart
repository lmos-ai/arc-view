import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:arc_view/src/chat/models/chat_message.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  factory Conversation({
    required List<ChatMessage> messages,
    required String conversationId,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, Object?> json) =>
      _$ConversationFromJson(json);
}
