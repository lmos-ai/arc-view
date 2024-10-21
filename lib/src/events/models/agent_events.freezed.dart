// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentEvent _$AgentEventFromJson(Map<String, dynamic> json) {
  return _AgentEvent.fromJson(json);
}

/// @nodoc
mixin _$AgentEvent {
  String get type => throw _privateConstructorUsedError;
  String get payload => throw _privateConstructorUsedError;
  String? get conversationId => throw _privateConstructorUsedError;

  /// Serializes this AgentEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AgentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgentEventCopyWith<AgentEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentEventCopyWith<$Res> {
  factory $AgentEventCopyWith(
          AgentEvent value, $Res Function(AgentEvent) then) =
      _$AgentEventCopyWithImpl<$Res, AgentEvent>;
  @useResult
  $Res call({String type, String payload, String? conversationId});
}

/// @nodoc
class _$AgentEventCopyWithImpl<$Res, $Val extends AgentEvent>
    implements $AgentEventCopyWith<$Res> {
  _$AgentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AgentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? payload = null,
    Object? conversationId = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentEventImplCopyWith<$Res>
    implements $AgentEventCopyWith<$Res> {
  factory _$$AgentEventImplCopyWith(
          _$AgentEventImpl value, $Res Function(_$AgentEventImpl) then) =
      __$$AgentEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String payload, String? conversationId});
}

/// @nodoc
class __$$AgentEventImplCopyWithImpl<$Res>
    extends _$AgentEventCopyWithImpl<$Res, _$AgentEventImpl>
    implements _$$AgentEventImplCopyWith<$Res> {
  __$$AgentEventImplCopyWithImpl(
      _$AgentEventImpl _value, $Res Function(_$AgentEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AgentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? payload = null,
    Object? conversationId = freezed,
  }) {
    return _then(_$AgentEventImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentEventImpl implements _AgentEvent {
  _$AgentEventImpl(
      {required this.type, required this.payload, this.conversationId});

  factory _$AgentEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentEventImplFromJson(json);

  @override
  final String type;
  @override
  final String payload;
  @override
  final String? conversationId;

  @override
  String toString() {
    return 'AgentEvent(type: $type, payload: $payload, conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgentEventImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, payload, conversationId);

  /// Create a copy of AgentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentEventImplCopyWith<_$AgentEventImpl> get copyWith =>
      __$$AgentEventImplCopyWithImpl<_$AgentEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentEventImplToJson(
      this,
    );
  }
}

abstract class _AgentEvent implements AgentEvent {
  factory _AgentEvent(
      {required final String type,
      required final String payload,
      final String? conversationId}) = _$AgentEventImpl;

  factory _AgentEvent.fromJson(Map<String, dynamic> json) =
      _$AgentEventImpl.fromJson;

  @override
  String get type;
  @override
  String get payload;
  @override
  String? get conversationId;

  /// Create a copy of AgentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgentEventImplCopyWith<_$AgentEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
