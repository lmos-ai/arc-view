// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_tool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestTool _$TestToolFromJson(Map<String, dynamic> json) {
  return _TestTool.fromJson(json);
}

/// @nodoc
mixin _$TestTool {
  String get name => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  List<TestToolParameter> get parameters => throw _privateConstructorUsedError;

  /// Serializes this TestTool to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestTool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestToolCopyWith<TestTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestToolCopyWith<$Res> {
  factory $TestToolCopyWith(TestTool value, $Res Function(TestTool) then) =
      _$TestToolCopyWithImpl<$Res, TestTool>;
  @useResult
  $Res call(
      {String name,
      String title,
      String id,
      String description,
      String value,
      List<TestToolParameter> parameters});
}

/// @nodoc
class _$TestToolCopyWithImpl<$Res, $Val extends TestTool>
    implements $TestToolCopyWith<$Res> {
  _$TestToolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestTool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? title = null,
    Object? id = null,
    Object? description = null,
    Object? value = null,
    Object? parameters = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<TestToolParameter>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestToolImplCopyWith<$Res>
    implements $TestToolCopyWith<$Res> {
  factory _$$TestToolImplCopyWith(
          _$TestToolImpl value, $Res Function(_$TestToolImpl) then) =
      __$$TestToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String title,
      String id,
      String description,
      String value,
      List<TestToolParameter> parameters});
}

/// @nodoc
class __$$TestToolImplCopyWithImpl<$Res>
    extends _$TestToolCopyWithImpl<$Res, _$TestToolImpl>
    implements _$$TestToolImplCopyWith<$Res> {
  __$$TestToolImplCopyWithImpl(
      _$TestToolImpl _value, $Res Function(_$TestToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestTool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? title = null,
    Object? id = null,
    Object? description = null,
    Object? value = null,
    Object? parameters = null,
  }) {
    return _then(_$TestToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<TestToolParameter>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestToolImpl extends _TestTool {
  _$TestToolImpl(
      {required this.name,
      required this.title,
      required this.id,
      required this.description,
      required this.value,
      required final List<TestToolParameter> parameters})
      : _parameters = parameters,
        super._();

  factory _$TestToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestToolImplFromJson(json);

  @override
  final String name;
  @override
  final String title;
  @override
  final String id;
  @override
  final String description;
  @override
  final String value;
  final List<TestToolParameter> _parameters;
  @override
  List<TestToolParameter> get parameters {
    if (_parameters is EqualUnmodifiableListView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parameters);
  }

  @override
  String toString() {
    return 'TestTool(name: $name, title: $title, id: $id, description: $description, value: $value, parameters: $parameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestToolImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, title, id, description,
      value, const DeepCollectionEquality().hash(_parameters));

  /// Create a copy of TestTool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestToolImplCopyWith<_$TestToolImpl> get copyWith =>
      __$$TestToolImplCopyWithImpl<_$TestToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestToolImplToJson(
      this,
    );
  }
}

abstract class _TestTool extends TestTool {
  factory _TestTool(
      {required final String name,
      required final String title,
      required final String id,
      required final String description,
      required final String value,
      required final List<TestToolParameter> parameters}) = _$TestToolImpl;
  _TestTool._() : super._();

  factory _TestTool.fromJson(Map<String, dynamic> json) =
      _$TestToolImpl.fromJson;

  @override
  String get name;
  @override
  String get title;
  @override
  String get id;
  @override
  String get description;
  @override
  String get value;
  @override
  List<TestToolParameter> get parameters;

  /// Create a copy of TestTool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestToolImplCopyWith<_$TestToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TestToolParameter _$TestToolParameterFromJson(Map<String, dynamic> json) {
  return _TestToolParameter.fromJson(json);
}

/// @nodoc
mixin _$TestToolParameter {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this TestToolParameter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestToolParameter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestToolParameterCopyWith<TestToolParameter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestToolParameterCopyWith<$Res> {
  factory $TestToolParameterCopyWith(
          TestToolParameter value, $Res Function(TestToolParameter) then) =
      _$TestToolParameterCopyWithImpl<$Res, TestToolParameter>;
  @useResult
  $Res call({String name, String description, String type});
}

/// @nodoc
class _$TestToolParameterCopyWithImpl<$Res, $Val extends TestToolParameter>
    implements $TestToolParameterCopyWith<$Res> {
  _$TestToolParameterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestToolParameter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestToolParameterImplCopyWith<$Res>
    implements $TestToolParameterCopyWith<$Res> {
  factory _$$TestToolParameterImplCopyWith(_$TestToolParameterImpl value,
          $Res Function(_$TestToolParameterImpl) then) =
      __$$TestToolParameterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String description, String type});
}

/// @nodoc
class __$$TestToolParameterImplCopyWithImpl<$Res>
    extends _$TestToolParameterCopyWithImpl<$Res, _$TestToolParameterImpl>
    implements _$$TestToolParameterImplCopyWith<$Res> {
  __$$TestToolParameterImplCopyWithImpl(_$TestToolParameterImpl _value,
      $Res Function(_$TestToolParameterImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestToolParameter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? type = null,
  }) {
    return _then(_$TestToolParameterImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestToolParameterImpl extends _TestToolParameter {
  _$TestToolParameterImpl(
      {required this.name, required this.description, required this.type})
      : super._();

  factory _$TestToolParameterImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestToolParameterImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  final String type;

  @override
  String toString() {
    return 'TestToolParameter(name: $name, description: $description, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestToolParameterImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, type);

  /// Create a copy of TestToolParameter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestToolParameterImplCopyWith<_$TestToolParameterImpl> get copyWith =>
      __$$TestToolParameterImplCopyWithImpl<_$TestToolParameterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestToolParameterImplToJson(
      this,
    );
  }
}

abstract class _TestToolParameter extends TestToolParameter {
  factory _TestToolParameter(
      {required final String name,
      required final String description,
      required final String type}) = _$TestToolParameterImpl;
  _TestToolParameter._() : super._();

  factory _TestToolParameter.fromJson(Map<String, dynamic> json) =
      _$TestToolParameterImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  String get type;

  /// Create a copy of TestToolParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestToolParameterImplCopyWith<_$TestToolParameterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
