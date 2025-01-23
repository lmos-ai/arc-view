// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_cases.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestCasesImpl _$$TestCasesImplFromJson(Map<String, dynamic> json) =>
    _$TestCasesImpl(
      testCases: (json['testCases'] as List<dynamic>)
          .map((e) => TestCase.fromJson(e as Map<String, dynamic>))
          .toList(),
      runs: (json['runs'] as List<dynamic>)
          .map((e) => TestRun.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TestCasesImplToJson(_$TestCasesImpl instance) =>
    <String, dynamic>{
      'testCases': instance.testCases,
      'runs': instance.runs,
    };
