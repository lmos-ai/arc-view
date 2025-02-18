// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestToolImpl _$$TestToolImplFromJson(Map<String, dynamic> json) =>
    _$TestToolImpl(
      name: json['name'] as String,
      title: json['title'] as String,
      id: json['id'] as String,
      description: json['description'] as String,
      value: json['value'] as String,
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => TestToolParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TestToolImplToJson(_$TestToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'id': instance.id,
      'description': instance.description,
      'value': instance.value,
      'parameters': instance.parameters,
    };

_$TestToolParameterImpl _$$TestToolParameterImplFromJson(
        Map<String, dynamic> json) =>
    _$TestToolParameterImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$TestToolParameterImplToJson(
        _$TestToolParameterImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
    };
