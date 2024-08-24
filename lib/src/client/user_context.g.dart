// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserContextImpl _$$UserContextImplFromJson(Map<String, dynamic> json) =>
    _$UserContextImpl(
      profile: (json['profile'] as List<dynamic>)
          .map((e) => ProfileEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: json['userId'] as String,
      userToken: json['userToken'] as String?,
    );

Map<String, dynamic> _$$UserContextImplToJson(_$UserContextImpl instance) =>
    <String, dynamic>{
      'profile': instance.profile,
      'userId': instance.userId,
      'userToken': instance.userToken,
    };

_$ProfileEntryImpl _$$ProfileEntryImplFromJson(Map<String, dynamic> json) =>
    _$ProfileEntryImpl(
      key: json['key'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$ProfileEntryImplToJson(_$ProfileEntryImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
