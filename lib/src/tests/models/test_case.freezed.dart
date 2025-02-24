// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_case.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestCase _$TestCaseFromJson(Map<String, dynamic> json) {
  return _TestCase.fromJson(json);
}

/// @nodoc
mixin _$TestCase {
  String get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  Conversation get expected => throw _privateConstructorUsedError;

  /// Serializes this TestCase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestCaseCopyWith<TestCase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestCaseCopyWith<$Res> {
  factory $TestCaseCopyWith(TestCase value, $Res Function(TestCase) then) =
      _$TestCaseCopyWithImpl<$Res, TestCase>;
  @useResult
  $Res call({String name, DateTime createdAt, Conversation expected});

  $ConversationCopyWith<$Res> get expected;
}

/// @nodoc
class _$TestCaseCopyWithImpl<$Res, $Val extends TestCase>
    implements $TestCaseCopyWith<$Res> {
  _$TestCaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? createdAt = null,
    Object? expected = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expected: null == expected
          ? _value.expected
          : expected // ignore: cast_nullable_to_non_nullable
              as Conversation,
    ) as $Val);
  }

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConversationCopyWith<$Res> get expected {
    return $ConversationCopyWith<$Res>(_value.expected, (value) {
      return _then(_value.copyWith(expected: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TestCaseImplCopyWith<$Res>
    implements $TestCaseCopyWith<$Res> {
  factory _$$TestCaseImplCopyWith(
          _$TestCaseImpl value, $Res Function(_$TestCaseImpl) then) =
      __$$TestCaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, DateTime createdAt, Conversation expected});

  @override
  $ConversationCopyWith<$Res> get expected;
}

/// @nodoc
class __$$TestCaseImplCopyWithImpl<$Res>
    extends _$TestCaseCopyWithImpl<$Res, _$TestCaseImpl>
    implements _$$TestCaseImplCopyWith<$Res> {
  __$$TestCaseImplCopyWithImpl(
      _$TestCaseImpl _value, $Res Function(_$TestCaseImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? createdAt = null,
    Object? expected = null,
  }) {
    return _then(_$TestCaseImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expected: null == expected
          ? _value.expected
          : expected // ignore: cast_nullable_to_non_nullable
              as Conversation,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestCaseImpl extends _TestCase {
  _$TestCaseImpl(
      {required this.name, required this.createdAt, required this.expected})
      : super._();

  factory _$TestCaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestCaseImplFromJson(json);

  @override
  final String name;
  @override
  final DateTime createdAt;
  @override
  final Conversation expected;

  @override
  String toString() {
    return 'TestCase(name: $name, createdAt: $createdAt, expected: $expected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestCaseImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expected, expected) ||
                other.expected == expected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, createdAt, expected);

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestCaseImplCopyWith<_$TestCaseImpl> get copyWith =>
      __$$TestCaseImplCopyWithImpl<_$TestCaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestCaseImplToJson(
      this,
    );
  }
}

abstract class _TestCase extends TestCase {
  factory _TestCase(
      {required final String name,
      required final DateTime createdAt,
      required final Conversation expected}) = _$TestCaseImpl;
  _TestCase._() : super._();

  factory _TestCase.fromJson(Map<String, dynamic> json) =
      _$TestCaseImpl.fromJson;

  @override
  String get name;
  @override
  DateTime get createdAt;
  @override
  Conversation get expected;

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestCaseImplCopyWith<_$TestCaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
