// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationMessageImpl _$$ConversationMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$ConversationMessageImpl(
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      conversationId: json['conversationId'] as String,
      content: json['content'] as String,
      responseTime: (json['responseTime'] as num?)?.toDouble(),
      agent: json['agent'] as String?,
    );

Map<String, dynamic> _$$ConversationMessageImplToJson(
        _$ConversationMessageImpl instance) =>
    <String, dynamic>{
      'type': _$MessageTypeEnumMap[instance.type]!,
      'conversationId': instance.conversationId,
      'content': instance.content,
      'responseTime': instance.responseTime,
      'agent': instance.agent,
    };

const _$MessageTypeEnumMap = {
  MessageType.user: 'user',
  MessageType.bot: 'bot',
  MessageType.loading: 'loading',
};
