// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => ConversationMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      userContext:
          UserContext.fromJson(json['userContext'] as Map<String, dynamic>),
      systemContext:
          SystemContext.fromJson(json['systemContext'] as Map<String, dynamic>),
      conversationId: json['conversationId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      loading: json['loading'] as bool?,
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'userContext': instance.userContext,
      'systemContext': instance.systemContext,
      'conversationId': instance.conversationId,
      'createdAt': instance.createdAt.toIso8601String(),
      'loading': instance.loading,
    };
