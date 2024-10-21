// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Settings _$SettingsFromJson(Map<String, dynamic> json) {
  return _Settings.fromJson(json);
}

/// @nodoc
mixin _$Settings {
  bool get changed => throw _privateConstructorUsedError;
  String? get newUserContext => throw _privateConstructorUsedError;
  String? get newSystemContext => throw _privateConstructorUsedError;

  /// Serializes this Settings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Settings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsCopyWith<Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res, Settings>;
  @useResult
  $Res call({bool changed, String? newUserContext, String? newSystemContext});
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res, $Val extends Settings>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Settings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? changed = null,
    Object? newUserContext = freezed,
    Object? newSystemContext = freezed,
  }) {
    return _then(_value.copyWith(
      changed: null == changed
          ? _value.changed
          : changed // ignore: cast_nullable_to_non_nullable
              as bool,
      newUserContext: freezed == newUserContext
          ? _value.newUserContext
          : newUserContext // ignore: cast_nullable_to_non_nullable
              as String?,
      newSystemContext: freezed == newSystemContext
          ? _value.newSystemContext
          : newSystemContext // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsImplCopyWith<$Res>
    implements $SettingsCopyWith<$Res> {
  factory _$$SettingsImplCopyWith(
          _$SettingsImpl value, $Res Function(_$SettingsImpl) then) =
      __$$SettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool changed, String? newUserContext, String? newSystemContext});
}

/// @nodoc
class __$$SettingsImplCopyWithImpl<$Res>
    extends _$SettingsCopyWithImpl<$Res, _$SettingsImpl>
    implements _$$SettingsImplCopyWith<$Res> {
  __$$SettingsImplCopyWithImpl(
      _$SettingsImpl _value, $Res Function(_$SettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Settings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? changed = null,
    Object? newUserContext = freezed,
    Object? newSystemContext = freezed,
  }) {
    return _then(_$SettingsImpl(
      changed: null == changed
          ? _value.changed
          : changed // ignore: cast_nullable_to_non_nullable
              as bool,
      newUserContext: freezed == newUserContext
          ? _value.newUserContext
          : newUserContext // ignore: cast_nullable_to_non_nullable
              as String?,
      newSystemContext: freezed == newSystemContext
          ? _value.newSystemContext
          : newSystemContext // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsImpl implements _Settings {
  _$SettingsImpl(
      {required this.changed,
      required this.newUserContext,
      required this.newSystemContext});

  factory _$SettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsImplFromJson(json);

  @override
  final bool changed;
  @override
  final String? newUserContext;
  @override
  final String? newSystemContext;

  @override
  String toString() {
    return 'Settings(changed: $changed, newUserContext: $newUserContext, newSystemContext: $newSystemContext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsImpl &&
            (identical(other.changed, changed) || other.changed == changed) &&
            (identical(other.newUserContext, newUserContext) ||
                other.newUserContext == newUserContext) &&
            (identical(other.newSystemContext, newSystemContext) ||
                other.newSystemContext == newSystemContext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, changed, newUserContext, newSystemContext);

  /// Create a copy of Settings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsImplCopyWith<_$SettingsImpl> get copyWith =>
      __$$SettingsImplCopyWithImpl<_$SettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsImplToJson(
      this,
    );
  }
}

abstract class _Settings implements Settings {
  factory _Settings(
      {required final bool changed,
      required final String? newUserContext,
      required final String? newSystemContext}) = _$SettingsImpl;

  factory _Settings.fromJson(Map<String, dynamic> json) =
      _$SettingsImpl.fromJson;

  @override
  bool get changed;
  @override
  String? get newUserContext;
  @override
  String? get newSystemContext;

  /// Create a copy of Settings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsImplCopyWith<_$SettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
