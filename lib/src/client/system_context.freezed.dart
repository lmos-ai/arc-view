/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SystemContext _$SystemContextFromJson(Map<String, dynamic> json) {
  return _SystemContext.fromJson(json);
}

/// @nodoc
mixin _$SystemContext {
  List<({String key, String value})> get entries =>
      throw _privateConstructorUsedError;

  /// Serializes this SystemContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SystemContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SystemContextCopyWith<SystemContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemContextCopyWith<$Res> {
  factory $SystemContextCopyWith(
          SystemContext value, $Res Function(SystemContext) then) =
      _$SystemContextCopyWithImpl<$Res, SystemContext>;
  @useResult
  $Res call({List<({String key, String value})> entries});
}

/// @nodoc
class _$SystemContextCopyWithImpl<$Res, $Val extends SystemContext>
    implements $SystemContextCopyWith<$Res> {
  _$SystemContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SystemContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
  }) {
    return _then(_value.copyWith(
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<({String key, String value})>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SystemContextImplCopyWith<$Res>
    implements $SystemContextCopyWith<$Res> {
  factory _$$SystemContextImplCopyWith(
          _$SystemContextImpl value, $Res Function(_$SystemContextImpl) then) =
      __$$SystemContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<({String key, String value})> entries});
}

/// @nodoc
class __$$SystemContextImplCopyWithImpl<$Res>
    extends _$SystemContextCopyWithImpl<$Res, _$SystemContextImpl>
    implements _$$SystemContextImplCopyWith<$Res> {
  __$$SystemContextImplCopyWithImpl(
      _$SystemContextImpl _value, $Res Function(_$SystemContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of SystemContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
  }) {
    return _then(_$SystemContextImpl(
      entries: null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<({String key, String value})>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SystemContextImpl implements _SystemContext {
  _$SystemContextImpl(
      {required final List<({String key, String value})> entries})
      : _entries = entries;

  factory _$SystemContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$SystemContextImplFromJson(json);

  final List<({String key, String value})> _entries;
  @override
  List<({String key, String value})> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  String toString() {
    return 'SystemContext(entries: $entries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SystemContextImpl &&
            const DeepCollectionEquality().equals(other._entries, _entries));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_entries));

  /// Create a copy of SystemContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SystemContextImplCopyWith<_$SystemContextImpl> get copyWith =>
      __$$SystemContextImplCopyWithImpl<_$SystemContextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SystemContextImplToJson(
      this,
    );
  }
}

abstract class _SystemContext implements SystemContext {
  factory _SystemContext(
          {required final List<({String key, String value})> entries}) =
      _$SystemContextImpl;

  factory _SystemContext.fromJson(Map<String, dynamic> json) =
      _$SystemContextImpl.fromJson;

  @override
  List<({String key, String value})> get entries;

  /// Create a copy of SystemContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SystemContextImplCopyWith<_$SystemContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
