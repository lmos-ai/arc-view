/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SystemContextImpl _$$SystemContextImplFromJson(Map<String, dynamic> json) =>
    _$SystemContextImpl(
      entries: (json['entries'] as List<dynamic>)
          .map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  key: $jsonValue['key'] as String,
                  value: $jsonValue['value'] as String,
                ),
              ))
          .toList(),
    );

Map<String, dynamic> _$$SystemContextImplToJson(_$SystemContextImpl instance) =>
    <String, dynamic>{
      'entries': instance.entries
          .map((e) => <String, dynamic>{
                'key': e.key,
                'value': e.value,
              })
          .toList(),
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
