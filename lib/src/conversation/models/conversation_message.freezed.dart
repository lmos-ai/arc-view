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
  List<BinaryData>? get binaryData => throw _privateConstructorUsedError;
  double? get responseTime => throw _privateConstructorUsedError;
  String? get agent => throw _privateConstructorUsedError;

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
      List<BinaryData>? binaryData,
      double? responseTime,
      String? agent});
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
    Object? binaryData = freezed,
    Object? responseTime = freezed,
    Object? agent = freezed,
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
      binaryData: freezed == binaryData
          ? _value.binaryData
          : binaryData // ignore: cast_nullable_to_non_nullable
              as List<BinaryData>?,
      responseTime: freezed == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as double?,
      agent: freezed == agent
          ? _value.agent
          : agent // ignore: cast_nullable_to_non_nullable
              as String?,
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
      List<BinaryData>? binaryData,
      double? responseTime,
      String? agent});
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
    Object? binaryData = freezed,
    Object? responseTime = freezed,
    Object? agent = freezed,
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
      binaryData: freezed == binaryData
          ? _value._binaryData
          : binaryData // ignore: cast_nullable_to_non_nullable
              as List<BinaryData>?,
      responseTime: freezed == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as double?,
      agent: freezed == agent
          ? _value.agent
          : agent // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationMessageImpl extends _ConversationMessage {
  _$ConversationMessageImpl(
      {required this.type,
      required this.conversationId,
      required this.content,
      final List<BinaryData>? binaryData,
      this.responseTime,
      this.agent})
      : _binaryData = binaryData,
        super._();

  factory _$ConversationMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationMessageImplFromJson(json);

  @override
  final MessageType type;
  @override
  final String conversationId;
  @override
  final String content;
  final List<BinaryData>? _binaryData;
  @override
  List<BinaryData>? get binaryData {
    final value = _binaryData;
    if (value == null) return null;
    if (_binaryData is EqualUnmodifiableListView) return _binaryData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? responseTime;
  @override
  final String? agent;

  @override
  String toString() {
    return 'ConversationMessage(type: $type, conversationId: $conversationId, content: $content, binaryData: $binaryData, responseTime: $responseTime, agent: $agent)';
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
            const DeepCollectionEquality()
                .equals(other._binaryData, _binaryData) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime) &&
            (identical(other.agent, agent) || other.agent == agent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, conversationId, content,
      const DeepCollectionEquality().hash(_binaryData), responseTime, agent);

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

abstract class _ConversationMessage extends ConversationMessage {
  factory _ConversationMessage(
      {required final MessageType type,
      required final String conversationId,
      required final String content,
      final List<BinaryData>? binaryData,
      final double? responseTime,
      final String? agent}) = _$ConversationMessageImpl;
  _ConversationMessage._() : super._();

  factory _ConversationMessage.fromJson(Map<String, dynamic> json) =
      _$ConversationMessageImpl.fromJson;

  @override
  MessageType get type;
  @override
  String get conversationId;
  @override
  String get content;
  @override
  List<BinaryData>? get binaryData;
  @override
  double? get responseTime;
  @override
  String? get agent;

  /// Create a copy of ConversationMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationMessageImplCopyWith<_$ConversationMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BinaryData _$BinaryDataFromJson(Map<String, dynamic> json) {
  return _BinaryData.fromJson(json);
}

/// @nodoc
mixin _$BinaryData {
  String? get dataAsBase64 => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;

  /// Serializes this BinaryData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BinaryData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BinaryDataCopyWith<BinaryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BinaryDataCopyWith<$Res> {
  factory $BinaryDataCopyWith(
          BinaryData value, $Res Function(BinaryData) then) =
      _$BinaryDataCopyWithImpl<$Res, BinaryData>;
  @useResult
  $Res call({String? dataAsBase64, String mimeType, String? source});
}

/// @nodoc
class _$BinaryDataCopyWithImpl<$Res, $Val extends BinaryData>
    implements $BinaryDataCopyWith<$Res> {
  _$BinaryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BinaryData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataAsBase64 = freezed,
    Object? mimeType = null,
    Object? source = freezed,
  }) {
    return _then(_value.copyWith(
      dataAsBase64: freezed == dataAsBase64
          ? _value.dataAsBase64
          : dataAsBase64 // ignore: cast_nullable_to_non_nullable
              as String?,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BinaryDataImplCopyWith<$Res>
    implements $BinaryDataCopyWith<$Res> {
  factory _$$BinaryDataImplCopyWith(
          _$BinaryDataImpl value, $Res Function(_$BinaryDataImpl) then) =
      __$$BinaryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? dataAsBase64, String mimeType, String? source});
}

/// @nodoc
class __$$BinaryDataImplCopyWithImpl<$Res>
    extends _$BinaryDataCopyWithImpl<$Res, _$BinaryDataImpl>
    implements _$$BinaryDataImplCopyWith<$Res> {
  __$$BinaryDataImplCopyWithImpl(
      _$BinaryDataImpl _value, $Res Function(_$BinaryDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of BinaryData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataAsBase64 = freezed,
    Object? mimeType = null,
    Object? source = freezed,
  }) {
    return _then(_$BinaryDataImpl(
      dataAsBase64: freezed == dataAsBase64
          ? _value.dataAsBase64
          : dataAsBase64 // ignore: cast_nullable_to_non_nullable
              as String?,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BinaryDataImpl implements _BinaryData {
  _$BinaryDataImpl({this.dataAsBase64, required this.mimeType, this.source});

  factory _$BinaryDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BinaryDataImplFromJson(json);

  @override
  final String? dataAsBase64;
  @override
  final String mimeType;
  @override
  final String? source;

  @override
  String toString() {
    return 'BinaryData(dataAsBase64: $dataAsBase64, mimeType: $mimeType, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BinaryDataImpl &&
            (identical(other.dataAsBase64, dataAsBase64) ||
                other.dataAsBase64 == dataAsBase64) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, dataAsBase64, mimeType, source);

  /// Create a copy of BinaryData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BinaryDataImplCopyWith<_$BinaryDataImpl> get copyWith =>
      __$$BinaryDataImplCopyWithImpl<_$BinaryDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BinaryDataImplToJson(
      this,
    );
  }
}

abstract class _BinaryData implements BinaryData {
  factory _BinaryData(
      {final String? dataAsBase64,
      required final String mimeType,
      final String? source}) = _$BinaryDataImpl;

  factory _BinaryData.fromJson(Map<String, dynamic> json) =
      _$BinaryDataImpl.fromJson;

  @override
  String? get dataAsBase64;
  @override
  String get mimeType;
  @override
  String? get source;

  /// Create a copy of BinaryData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BinaryDataImplCopyWith<_$BinaryDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
