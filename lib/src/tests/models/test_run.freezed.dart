// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_run.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestRun _$TestRunFromJson(Map<String, dynamic> json) {
  return _TestRun.fromJson(json);
}

/// @nodoc
mixin _$TestRun {
  TestCase get testCase => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;

  /// Serializes this TestRun to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestRunCopyWith<TestRun> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestRunCopyWith<$Res> {
  factory $TestRunCopyWith(TestRun value, $Res Function(TestRun) then) =
      _$TestRunCopyWithImpl<$Res, TestRun>;
  @useResult
  $Res call({TestCase testCase, String conversationId, DateTime startedAt});

  $TestCaseCopyWith<$Res> get testCase;
}

/// @nodoc
class _$TestRunCopyWithImpl<$Res, $Val extends TestRun>
    implements $TestRunCopyWith<$Res> {
  _$TestRunCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testCase = null,
    Object? conversationId = null,
    Object? startedAt = null,
  }) {
    return _then(_value.copyWith(
      testCase: null == testCase
          ? _value.testCase
          : testCase // ignore: cast_nullable_to_non_nullable
              as TestCase,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TestCaseCopyWith<$Res> get testCase {
    return $TestCaseCopyWith<$Res>(_value.testCase, (value) {
      return _then(_value.copyWith(testCase: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TestRunImplCopyWith<$Res> implements $TestRunCopyWith<$Res> {
  factory _$$TestRunImplCopyWith(
          _$TestRunImpl value, $Res Function(_$TestRunImpl) then) =
      __$$TestRunImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TestCase testCase, String conversationId, DateTime startedAt});

  @override
  $TestCaseCopyWith<$Res> get testCase;
}

/// @nodoc
class __$$TestRunImplCopyWithImpl<$Res>
    extends _$TestRunCopyWithImpl<$Res, _$TestRunImpl>
    implements _$$TestRunImplCopyWith<$Res> {
  __$$TestRunImplCopyWithImpl(
      _$TestRunImpl _value, $Res Function(_$TestRunImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testCase = null,
    Object? conversationId = null,
    Object? startedAt = null,
  }) {
    return _then(_$TestRunImpl(
      testCase: null == testCase
          ? _value.testCase
          : testCase // ignore: cast_nullable_to_non_nullable
              as TestCase,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestRunImpl extends _TestRun {
  _$TestRunImpl(
      {required this.testCase,
      required this.conversationId,
      required this.startedAt})
      : super._();

  factory _$TestRunImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestRunImplFromJson(json);

  @override
  final TestCase testCase;
  @override
  final String conversationId;
  @override
  final DateTime startedAt;

  @override
  String toString() {
    return 'TestRun(testCase: $testCase, conversationId: $conversationId, startedAt: $startedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestRunImpl &&
            (identical(other.testCase, testCase) ||
                other.testCase == testCase) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, testCase, conversationId, startedAt);

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestRunImplCopyWith<_$TestRunImpl> get copyWith =>
      __$$TestRunImplCopyWithImpl<_$TestRunImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestRunImplToJson(
      this,
    );
  }
}

abstract class _TestRun extends TestRun {
  factory _TestRun(
      {required final TestCase testCase,
      required final String conversationId,
      required final DateTime startedAt}) = _$TestRunImpl;
  _TestRun._() : super._();

  factory _TestRun.fromJson(Map<String, dynamic> json) = _$TestRunImpl.fromJson;

  @override
  TestCase get testCase;
  @override
  String get conversationId;
  @override
  DateTime get startedAt;

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestRunImplCopyWith<_$TestRunImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
