// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_cases.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestCases _$TestCasesFromJson(Map<String, dynamic> json) {
  return _TestCases.fromJson(json);
}

/// @nodoc
mixin _$TestCases {
  List<TestCase> get testCases => throw _privateConstructorUsedError;
  List<TestRun> get runs => throw _privateConstructorUsedError;

  /// Serializes this TestCases to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestCases
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestCasesCopyWith<TestCases> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestCasesCopyWith<$Res> {
  factory $TestCasesCopyWith(TestCases value, $Res Function(TestCases) then) =
      _$TestCasesCopyWithImpl<$Res, TestCases>;
  @useResult
  $Res call({List<TestCase> testCases, List<TestRun> runs});
}

/// @nodoc
class _$TestCasesCopyWithImpl<$Res, $Val extends TestCases>
    implements $TestCasesCopyWith<$Res> {
  _$TestCasesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestCases
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testCases = null,
    Object? runs = null,
  }) {
    return _then(_value.copyWith(
      testCases: null == testCases
          ? _value.testCases
          : testCases // ignore: cast_nullable_to_non_nullable
              as List<TestCase>,
      runs: null == runs
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as List<TestRun>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestCasesImplCopyWith<$Res>
    implements $TestCasesCopyWith<$Res> {
  factory _$$TestCasesImplCopyWith(
          _$TestCasesImpl value, $Res Function(_$TestCasesImpl) then) =
      __$$TestCasesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TestCase> testCases, List<TestRun> runs});
}

/// @nodoc
class __$$TestCasesImplCopyWithImpl<$Res>
    extends _$TestCasesCopyWithImpl<$Res, _$TestCasesImpl>
    implements _$$TestCasesImplCopyWith<$Res> {
  __$$TestCasesImplCopyWithImpl(
      _$TestCasesImpl _value, $Res Function(_$TestCasesImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestCases
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testCases = null,
    Object? runs = null,
  }) {
    return _then(_$TestCasesImpl(
      testCases: null == testCases
          ? _value._testCases
          : testCases // ignore: cast_nullable_to_non_nullable
              as List<TestCase>,
      runs: null == runs
          ? _value._runs
          : runs // ignore: cast_nullable_to_non_nullable
              as List<TestRun>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestCasesImpl extends _TestCases {
  _$TestCasesImpl(
      {required final List<TestCase> testCases,
      required final List<TestRun> runs})
      : _testCases = testCases,
        _runs = runs,
        super._();

  factory _$TestCasesImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestCasesImplFromJson(json);

  final List<TestCase> _testCases;
  @override
  List<TestCase> get testCases {
    if (_testCases is EqualUnmodifiableListView) return _testCases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_testCases);
  }

  final List<TestRun> _runs;
  @override
  List<TestRun> get runs {
    if (_runs is EqualUnmodifiableListView) return _runs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_runs);
  }

  @override
  String toString() {
    return 'TestCases(testCases: $testCases, runs: $runs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestCasesImpl &&
            const DeepCollectionEquality()
                .equals(other._testCases, _testCases) &&
            const DeepCollectionEquality().equals(other._runs, _runs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_testCases),
      const DeepCollectionEquality().hash(_runs));

  /// Create a copy of TestCases
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestCasesImplCopyWith<_$TestCasesImpl> get copyWith =>
      __$$TestCasesImplCopyWithImpl<_$TestCasesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestCasesImplToJson(
      this,
    );
  }
}

abstract class _TestCases extends TestCases {
  factory _TestCases(
      {required final List<TestCase> testCases,
      required final List<TestRun> runs}) = _$TestCasesImpl;
  _TestCases._() : super._();

  factory _TestCases.fromJson(Map<String, dynamic> json) =
      _$TestCasesImpl.fromJson;

  @override
  List<TestCase> get testCases;
  @override
  List<TestRun> get runs;

  /// Create a copy of TestCases
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestCasesImplCopyWith<_$TestCasesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
