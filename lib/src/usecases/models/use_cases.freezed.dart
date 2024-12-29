// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'use_cases.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UseCases _$UseCasesFromJson(Map<String, dynamic> json) {
  return _UseCases.fromJson(json);
}

/// @nodoc
mixin _$UseCases {
  List<UseCase> get cases => throw _privateConstructorUsedError;
  int get selected => throw _privateConstructorUsedError;

  /// Serializes this UseCases to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UseCases
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UseCasesCopyWith<UseCases> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UseCasesCopyWith<$Res> {
  factory $UseCasesCopyWith(UseCases value, $Res Function(UseCases) then) =
      _$UseCasesCopyWithImpl<$Res, UseCases>;
  @useResult
  $Res call({List<UseCase> cases, int selected});
}

/// @nodoc
class _$UseCasesCopyWithImpl<$Res, $Val extends UseCases>
    implements $UseCasesCopyWith<$Res> {
  _$UseCasesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UseCases
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cases = null,
    Object? selected = null,
  }) {
    return _then(_value.copyWith(
      cases: null == cases
          ? _value.cases
          : cases // ignore: cast_nullable_to_non_nullable
              as List<UseCase>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UseCasesImplCopyWith<$Res>
    implements $UseCasesCopyWith<$Res> {
  factory _$$UseCasesImplCopyWith(
          _$UseCasesImpl value, $Res Function(_$UseCasesImpl) then) =
      __$$UseCasesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UseCase> cases, int selected});
}

/// @nodoc
class __$$UseCasesImplCopyWithImpl<$Res>
    extends _$UseCasesCopyWithImpl<$Res, _$UseCasesImpl>
    implements _$$UseCasesImplCopyWith<$Res> {
  __$$UseCasesImplCopyWithImpl(
      _$UseCasesImpl _value, $Res Function(_$UseCasesImpl) _then)
      : super(_value, _then);

  /// Create a copy of UseCases
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cases = null,
    Object? selected = null,
  }) {
    return _then(_$UseCasesImpl(
      cases: null == cases
          ? _value._cases
          : cases // ignore: cast_nullable_to_non_nullable
              as List<UseCase>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UseCasesImpl extends _UseCases {
  _$UseCasesImpl({required final List<UseCase> cases, required this.selected})
      : _cases = cases,
        super._();

  factory _$UseCasesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UseCasesImplFromJson(json);

  final List<UseCase> _cases;
  @override
  List<UseCase> get cases {
    if (_cases is EqualUnmodifiableListView) return _cases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cases);
  }

  @override
  final int selected;

  @override
  String toString() {
    return 'UseCases(cases: $cases, selected: $selected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UseCasesImpl &&
            const DeepCollectionEquality().equals(other._cases, _cases) &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cases), selected);

  /// Create a copy of UseCases
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UseCasesImplCopyWith<_$UseCasesImpl> get copyWith =>
      __$$UseCasesImplCopyWithImpl<_$UseCasesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UseCasesImplToJson(
      this,
    );
  }
}

abstract class _UseCases extends UseCases {
  factory _UseCases(
      {required final List<UseCase> cases,
      required final int selected}) = _$UseCasesImpl;
  _UseCases._() : super._();

  factory _UseCases.fromJson(Map<String, dynamic> json) =
      _$UseCasesImpl.fromJson;

  @override
  List<UseCase> get cases;
  @override
  int get selected;

  /// Create a copy of UseCases
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UseCasesImplCopyWith<_$UseCasesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UseCase _$UseCaseFromJson(Map<String, dynamic> json) {
  return _UseCase.fromJson(json);
}

/// @nodoc
mixin _$UseCase {
  String get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  /// Serializes this UseCase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UseCase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UseCaseCopyWith<UseCase> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UseCaseCopyWith<$Res> {
  factory $UseCaseCopyWith(UseCase value, $Res Function(UseCase) then) =
      _$UseCaseCopyWithImpl<$Res, UseCase>;
  @useResult
  $Res call({String name, DateTime createdAt, String content});
}

/// @nodoc
class _$UseCaseCopyWithImpl<$Res, $Val extends UseCase>
    implements $UseCaseCopyWith<$Res> {
  _$UseCaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UseCase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? createdAt = null,
    Object? content = null,
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
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UseCaseImplCopyWith<$Res> implements $UseCaseCopyWith<$Res> {
  factory _$$UseCaseImplCopyWith(
          _$UseCaseImpl value, $Res Function(_$UseCaseImpl) then) =
      __$$UseCaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, DateTime createdAt, String content});
}

/// @nodoc
class __$$UseCaseImplCopyWithImpl<$Res>
    extends _$UseCaseCopyWithImpl<$Res, _$UseCaseImpl>
    implements _$$UseCaseImplCopyWith<$Res> {
  __$$UseCaseImplCopyWithImpl(
      _$UseCaseImpl _value, $Res Function(_$UseCaseImpl) _then)
      : super(_value, _then);

  /// Create a copy of UseCase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? createdAt = null,
    Object? content = null,
  }) {
    return _then(_$UseCaseImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UseCaseImpl implements _UseCase {
  _$UseCaseImpl(
      {required this.name, required this.createdAt, required this.content});

  factory _$UseCaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UseCaseImplFromJson(json);

  @override
  final String name;
  @override
  final DateTime createdAt;
  @override
  final String content;

  @override
  String toString() {
    return 'UseCase(name: $name, createdAt: $createdAt, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UseCaseImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, createdAt, content);

  /// Create a copy of UseCase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UseCaseImplCopyWith<_$UseCaseImpl> get copyWith =>
      __$$UseCaseImplCopyWithImpl<_$UseCaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UseCaseImplToJson(
      this,
    );
  }
}

abstract class _UseCase implements UseCase {
  factory _UseCase(
      {required final String name,
      required final DateTime createdAt,
      required final String content}) = _$UseCaseImpl;

  factory _UseCase.fromJson(Map<String, dynamic> json) = _$UseCaseImpl.fromJson;

  @override
  String get name;
  @override
  DateTime get createdAt;
  @override
  String get content;

  /// Create a copy of UseCase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UseCaseImplCopyWith<_$UseCaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
