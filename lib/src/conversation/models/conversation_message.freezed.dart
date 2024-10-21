// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConversationMessage _$ConversationMessageFromJson(Map<String, dynamic> json) {
  return _ConversationMessage.fromJson(json);
}

/// @nodoc
mixin _$ConversationMessage {
  MessageType get type => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  double? get responseTime => throw _privateConstructorUsedError;

  /// Serializes this ConversationMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConversationMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationMessageCopyWith<ConversationMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationMessageCopyWith<$Res> {
  factory $ConversationMessageCopyWith(
          ConversationMessage value, $Res Function(ConversationMessage) then) =
      _$ConversationMessageCopyWithImpl<$Res, ConversationMessage>;
  @useResult
  $Res call(
      {MessageType type,
      String conversationId,
      String content,
      double? responseTime});
}

/// @nodoc
class _$ConversationMessageCopyWithImpl<$Res, $Val extends ConversationMessage>
    implements $ConversationMessageCopyWith<$Res> {
  _$ConversationMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? conversationId = null,
    Object? content = null,
    Object? responseTime = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      responseTime: freezed == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConversationMessageImplCopyWith<$Res>
    implements $ConversationMessageCopyWith<$Res> {
  factory _$$ConversationMessageImplCopyWith(_$ConversationMessageImpl value,
          $Res Function(_$ConversationMessageImpl) then) =
      __$$ConversationMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MessageType type,
      String conversationId,
      String content,
      double? responseTime});
}

/// @nodoc
class __$$ConversationMessageImplCopyWithImpl<$Res>
    extends _$ConversationMessageCopyWithImpl<$Res, _$ConversationMessageImpl>
    implements _$$ConversationMessageImplCopyWith<$Res> {
  __$$ConversationMessageImplCopyWithImpl(_$ConversationMessageImpl _value,
      $Res Function(_$ConversationMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? conversationId = null,
    Object? content = null,
    Object? responseTime = freezed,
  }) {
    return _then(_$ConversationMessageImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      responseTime: freezed == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationMessageImpl implements _ConversationMessage {
  _$ConversationMessageImpl(
      {required this.type,
      required this.conversationId,
      required this.content,
      this.responseTime});

  factory _$ConversationMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationMessageImplFromJson(json);

  @override
  final MessageType type;
  @override
  final String conversationId;
  @override
  final String content;
  @override
  final double? responseTime;

  @override
  String toString() {
    return 'ConversationMessage(type: $type, conversationId: $conversationId, content: $content, responseTime: $responseTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationMessageImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, conversationId, content, responseTime);

  /// Create a copy of ConversationMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationMessageImplCopyWith<_$ConversationMessageImpl> get copyWith =>
      __$$ConversationMessageImplCopyWithImpl<_$ConversationMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationMessageImplToJson(
      this,
    );
  }
}

abstract class _ConversationMessage implements ConversationMessage {
  factory _ConversationMessage(
      {required final MessageType type,
      required final String conversationId,
      required final String content,
      final double? responseTime}) = _$ConversationMessageImpl;

  factory _ConversationMessage.fromJson(Map<String, dynamic> json) =
      _$ConversationMessageImpl.fromJson;

  @override
  MessageType get type;
  @override
  String get conversationId;
  @override
  String get content;
  @override
  double? get responseTime;

  /// Create a copy of ConversationMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationMessageImplCopyWith<_$ConversationMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
