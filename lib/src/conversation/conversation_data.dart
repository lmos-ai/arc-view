import 'package:arc_view/src/conversation/chat_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_data.freezed.dart';
part 'conversation_data.g.dart';

@freezed
class ConversationData with _$ConversationData {
  factory ConversationData({
    required List<ChatMessage> messages,
    required String conversationId,
  }) = _ConversationData;

  factory ConversationData.fromJson(Map<String, Object?> json) =>
      _$ConversationDataFromJson(json);
}
