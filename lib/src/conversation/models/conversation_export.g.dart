// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_export.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationExportImpl _$$ConversationExportImplFromJson(
        Map<String, dynamic> json) =>
    _$ConversationExportImpl(
      conversation:
          Conversation.fromJson(json['conversation'] as Map<String, dynamic>),
      events: (json['events'] as List<dynamic>)
          .map((e) => AgentEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ConversationExportImplToJson(
        _$ConversationExportImpl instance) =>
    <String, dynamic>{
      'conversation': instance.conversation,
      'events': instance.events,
    };
