// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MetricsImpl _$$MetricsImplFromJson(Map<String, dynamic> json) =>
    _$MetricsImpl(
      color: (json['color'] as num).toInt(),
      name: json['name'] as String,
      conversationId: json['conversationId'] as String?,
      plots: (json['plots'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$PlotTypeEnumMap, k),
            (e as List<dynamic>)
                .map((e) => Plot.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$$MetricsImplToJson(_$MetricsImpl instance) =>
    <String, dynamic>{
      'color': instance.color,
      'name': instance.name,
      'conversationId': instance.conversationId,
      'plots': instance.plots.map((k, e) => MapEntry(_$PlotTypeEnumMap[k]!, e)),
    };

const _$PlotTypeEnumMap = {
  PlotType.agentDuration: 'agentDuration',
  PlotType.agentBreaks: 'agentBreaks',
  PlotType.llmTotalTokens: 'llmTotalTokens',
  PlotType.llmFunctionCalls: 'llmFunctionCalls',
  PlotType.llmDuration: 'llmDuration',
  PlotType.llmPromptTokens: 'llmPromptTokens',
  PlotType.llmCompletionTokens: 'llmCompletionTokens',
};

_$PlotImpl _$$PlotImplFromJson(Map<String, dynamic> json) => _$PlotImpl(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );

Map<String, dynamic> _$$PlotImplToJson(_$PlotImpl instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };
