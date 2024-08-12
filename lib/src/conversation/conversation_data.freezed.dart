// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConversationData _$ConversationDataFromJson(Map<String, dynamic> json) {
  return _ConversationData.fromJson(json);
}

/// @nodoc
mixin _$ConversationData {
  List<ChatMessage> get messages => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;

  /// Serializes this ConversationData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConversationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationDataCopyWith<ConversationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationDataCopyWith<$Res> {
  factory $ConversationDataCopyWith(
          ConversationData value, $Res Function(ConversationData) then) =
      _$ConversationDataCopyWithImpl<$Res, ConversationData>;
  @useResult
  $Res call({List<ChatMessage> messages, String conversationId});
}

/// @nodoc
class _$ConversationDataCopyWithImpl<$Res, $Val extends ConversationData>
    implements $ConversationDataCopyWith<$Res> {
  _$ConversationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? conversationId = null,
  }) {
    return _then(_value.copyWith(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConversationDataImplCopyWith<$Res>
    implements $ConversationDataCopyWith<$Res> {
  factory _$$ConversationDataImplCopyWith(_$ConversationDataImpl value,
          $Res Function(_$ConversationDataImpl) then) =
      __$$ConversationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ChatMessage> messages, String conversationId});
}

/// @nodoc
class __$$ConversationDataImplCopyWithImpl<$Res>
    extends _$ConversationDataCopyWithImpl<$Res, _$ConversationDataImpl>
    implements _$$ConversationDataImplCopyWith<$Res> {
  __$$ConversationDataImplCopyWithImpl(_$ConversationDataImpl _value,
      $Res Function(_$ConversationDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? conversationId = null,
  }) {
    return _then(_$ConversationDataImpl(
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationDataImpl implements _ConversationData {
  _$ConversationDataImpl(
      {required final List<ChatMessage> messages, required this.conversationId})
      : _messages = messages;

  factory _$ConversationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationDataImplFromJson(json);

  final List<ChatMessage> _messages;
  @override
  List<ChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final String conversationId;

  @override
  String toString() {
    return 'ConversationData(messages: $messages, conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationDataImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_messages), conversationId);

  /// Create a copy of ConversationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationDataImplCopyWith<_$ConversationDataImpl> get copyWith =>
      __$$ConversationDataImplCopyWithImpl<_$ConversationDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationDataImplToJson(
      this,
    );
  }
}

abstract class _ConversationData implements ConversationData {
  factory _ConversationData(
      {required final List<ChatMessage> messages,
      required final String conversationId}) = _$ConversationDataImpl;

  factory _ConversationData.fromJson(Map<String, dynamic> json) =
      _$ConversationDataImpl.fromJson;

  @override
  List<ChatMessage> get messages;
  @override
  String get conversationId;

  /// Create a copy of ConversationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationDataImplCopyWith<_$ConversationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
