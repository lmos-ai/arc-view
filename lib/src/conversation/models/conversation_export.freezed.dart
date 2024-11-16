// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_export.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConversationExport _$ConversationExportFromJson(Map<String, dynamic> json) {
  return _ConversationExport.fromJson(json);
}

/// @nodoc
mixin _$ConversationExport {
  Conversation get conversation => throw _privateConstructorUsedError;
  List<AgentEvent> get events => throw _privateConstructorUsedError;

  /// Serializes this ConversationExport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConversationExport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationExportCopyWith<ConversationExport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationExportCopyWith<$Res> {
  factory $ConversationExportCopyWith(
          ConversationExport value, $Res Function(ConversationExport) then) =
      _$ConversationExportCopyWithImpl<$Res, ConversationExport>;
  @useResult
  $Res call({Conversation conversation, List<AgentEvent> events});

  $ConversationCopyWith<$Res> get conversation;
}

/// @nodoc
class _$ConversationExportCopyWithImpl<$Res, $Val extends ConversationExport>
    implements $ConversationExportCopyWith<$Res> {
  _$ConversationExportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationExport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversation = null,
    Object? events = null,
  }) {
    return _then(_value.copyWith(
      conversation: null == conversation
          ? _value.conversation
          : conversation // ignore: cast_nullable_to_non_nullable
              as Conversation,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<AgentEvent>,
    ) as $Val);
  }

  /// Create a copy of ConversationExport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConversationCopyWith<$Res> get conversation {
    return $ConversationCopyWith<$Res>(_value.conversation, (value) {
      return _then(_value.copyWith(conversation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConversationExportImplCopyWith<$Res>
    implements $ConversationExportCopyWith<$Res> {
  factory _$$ConversationExportImplCopyWith(_$ConversationExportImpl value,
          $Res Function(_$ConversationExportImpl) then) =
      __$$ConversationExportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Conversation conversation, List<AgentEvent> events});

  @override
  $ConversationCopyWith<$Res> get conversation;
}

/// @nodoc
class __$$ConversationExportImplCopyWithImpl<$Res>
    extends _$ConversationExportCopyWithImpl<$Res, _$ConversationExportImpl>
    implements _$$ConversationExportImplCopyWith<$Res> {
  __$$ConversationExportImplCopyWithImpl(_$ConversationExportImpl _value,
      $Res Function(_$ConversationExportImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationExport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversation = null,
    Object? events = null,
  }) {
    return _then(_$ConversationExportImpl(
      conversation: null == conversation
          ? _value.conversation
          : conversation // ignore: cast_nullable_to_non_nullable
              as Conversation,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<AgentEvent>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationExportImpl implements _ConversationExport {
  _$ConversationExportImpl(
      {required this.conversation, required final List<AgentEvent> events})
      : _events = events;

  factory _$ConversationExportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationExportImplFromJson(json);

  @override
  final Conversation conversation;
  final List<AgentEvent> _events;
  @override
  List<AgentEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  String toString() {
    return 'ConversationExport(conversation: $conversation, events: $events)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationExportImpl &&
            (identical(other.conversation, conversation) ||
                other.conversation == conversation) &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, conversation, const DeepCollectionEquality().hash(_events));

  /// Create a copy of ConversationExport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationExportImplCopyWith<_$ConversationExportImpl> get copyWith =>
      __$$ConversationExportImplCopyWithImpl<_$ConversationExportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationExportImplToJson(
      this,
    );
  }
}

abstract class _ConversationExport implements ConversationExport {
  factory _ConversationExport(
      {required final Conversation conversation,
      required final List<AgentEvent> events}) = _$ConversationExportImpl;

  factory _ConversationExport.fromJson(Map<String, dynamic> json) =
      _$ConversationExportImpl.fromJson;

  @override
  Conversation get conversation;
  @override
  List<AgentEvent> get events;

  /// Create a copy of ConversationExport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationExportImplCopyWith<_$ConversationExportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
