import 'dart:convert';

import 'package:arc_view/src/client/system_context.dart';
import 'package:arc_view/src/client/user_context.dart';
import 'package:arc_view/src/conversation/conversation_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  factory Conversation({
    required List<ConversationMessage> messages,
    required UserContext userContext,
    required SystemContext systemContext,
    required String conversationId,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
