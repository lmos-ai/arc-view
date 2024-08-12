// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationDataImpl _$$ConversationDataImplFromJson(
        Map<String, dynamic> json) =>
    _$ConversationDataImpl(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      conversationId: json['conversationId'] as String,
    );

Map<String, dynamic> _$$ConversationDataImplToJson(
        _$ConversationDataImpl instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'conversationId': instance.conversationId,
    };
