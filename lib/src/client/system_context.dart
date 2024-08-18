import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_context.freezed.dart';
part 'system_context.g.dart';

typedef SystemContextEntry = ({String key, String value});

@freezed
class SystemContext with _$SystemContext {
  factory SystemContext({required List<SystemContextEntry> entries}) =
      _SystemContext;

  factory SystemContext.fromJson(Map<String, dynamic> json) =>
      _$SystemContextFromJson(json);
}
