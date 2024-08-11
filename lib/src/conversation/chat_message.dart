import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

enum MessageType { user, bot, loading }

@freezed
class ChatMessage with _$ChatMessage {
  factory ChatMessage({
    required MessageType type,
    required String conversationId,
    required String content,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, Object?> json) =>
      _$ChatMessageFromJson(json);
}
