// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserContext _$UserContextFromJson(Map<String, dynamic> json) {
  return _UserContext.fromJson(json);
}

/// @nodoc
mixin _$UserContext {
  List<ProfileEntry> get profile => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get userToken => throw _privateConstructorUsedError;

  /// Serializes this UserContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserContextCopyWith<UserContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserContextCopyWith<$Res> {
  factory $UserContextCopyWith(
          UserContext value, $Res Function(UserContext) then) =
      _$UserContextCopyWithImpl<$Res, UserContext>;
  @useResult
  $Res call({List<ProfileEntry> profile, String userId, String? userToken});
}

/// @nodoc
class _$UserContextCopyWithImpl<$Res, $Val extends UserContext>
    implements $UserContextCopyWith<$Res> {
  _$UserContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? userId = null,
    Object? userToken = freezed,
  }) {
    return _then(_value.copyWith(
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as List<ProfileEntry>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userToken: freezed == userToken
          ? _value.userToken
          : userToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserContextImplCopyWith<$Res>
    implements $UserContextCopyWith<$Res> {
  factory _$$UserContextImplCopyWith(
          _$UserContextImpl value, $Res Function(_$UserContextImpl) then) =
      __$$UserContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ProfileEntry> profile, String userId, String? userToken});
}

/// @nodoc
class __$$UserContextImplCopyWithImpl<$Res>
    extends _$UserContextCopyWithImpl<$Res, _$UserContextImpl>
    implements _$$UserContextImplCopyWith<$Res> {
  __$$UserContextImplCopyWithImpl(
      _$UserContextImpl _value, $Res Function(_$UserContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? userId = null,
    Object? userToken = freezed,
  }) {
    return _then(_$UserContextImpl(
      profile: null == profile
          ? _value._profile
          : profile // ignore: cast_nullable_to_non_nullable
              as List<ProfileEntry>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userToken: freezed == userToken
          ? _value.userToken
          : userToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserContextImpl implements _UserContext {
  _$UserContextImpl(
      {required final List<ProfileEntry> profile,
      required this.userId,
      this.userToken})
      : _profile = profile;

  factory _$UserContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserContextImplFromJson(json);

  final List<ProfileEntry> _profile;
  @override
  List<ProfileEntry> get profile {
    if (_profile is EqualUnmodifiableListView) return _profile;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_profile);
  }

  @override
  final String userId;
  @override
  final String? userToken;

  @override
  String toString() {
    return 'UserContext(profile: $profile, userId: $userId, userToken: $userToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserContextImpl &&
            const DeepCollectionEquality().equals(other._profile, _profile) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userToken, userToken) ||
                other.userToken == userToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_profile), userId, userToken);

  /// Create a copy of UserContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserContextImplCopyWith<_$UserContextImpl> get copyWith =>
      __$$UserContextImplCopyWithImpl<_$UserContextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserContextImplToJson(
      this,
    );
  }
}

abstract class _UserContext implements UserContext {
  factory _UserContext(
      {required final List<ProfileEntry> profile,
      required final String userId,
      final String? userToken}) = _$UserContextImpl;

  factory _UserContext.fromJson(Map<String, dynamic> json) =
      _$UserContextImpl.fromJson;

  @override
  List<ProfileEntry> get profile;
  @override
  String get userId;
  @override
  String? get userToken;

  /// Create a copy of UserContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserContextImplCopyWith<_$UserContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileEntry _$ProfileEntryFromJson(Map<String, dynamic> json) {
  return _ProfileEntry.fromJson(json);
}

/// @nodoc
mixin _$ProfileEntry {
  String get key => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  /// Serializes this ProfileEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileEntryCopyWith<ProfileEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEntryCopyWith<$Res> {
  factory $ProfileEntryCopyWith(
          ProfileEntry value, $Res Function(ProfileEntry) then) =
      _$ProfileEntryCopyWithImpl<$Res, ProfileEntry>;
  @useResult
  $Res call({String key, String value});
}

/// @nodoc
class _$ProfileEntryCopyWithImpl<$Res, $Val extends ProfileEntry>
    implements $ProfileEntryCopyWith<$Res> {
  _$ProfileEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileEntryImplCopyWith<$Res>
    implements $ProfileEntryCopyWith<$Res> {
  factory _$$ProfileEntryImplCopyWith(
          _$ProfileEntryImpl value, $Res Function(_$ProfileEntryImpl) then) =
      __$$ProfileEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, String value});
}

/// @nodoc
class __$$ProfileEntryImplCopyWithImpl<$Res>
    extends _$ProfileEntryCopyWithImpl<$Res, _$ProfileEntryImpl>
    implements _$$ProfileEntryImplCopyWith<$Res> {
  __$$ProfileEntryImplCopyWithImpl(
      _$ProfileEntryImpl _value, $Res Function(_$ProfileEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
  }) {
    return _then(_$ProfileEntryImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileEntryImpl implements _ProfileEntry {
  _$ProfileEntryImpl({required this.key, required this.value});

  factory _$ProfileEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileEntryImplFromJson(json);

  @override
  final String key;
  @override
  final String value;

  @override
  String toString() {
    return 'ProfileEntry(key: $key, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileEntryImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key, value);

  /// Create a copy of ProfileEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileEntryImplCopyWith<_$ProfileEntryImpl> get copyWith =>
      __$$ProfileEntryImplCopyWithImpl<_$ProfileEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileEntryImplToJson(
      this,
    );
  }
}

abstract class _ProfileEntry implements ProfileEntry {
  factory _ProfileEntry(
      {required final String key,
      required final String value}) = _$ProfileEntryImpl;

  factory _ProfileEntry.fromJson(Map<String, dynamic> json) =
      _$ProfileEntryImpl.fromJson;

  @override
  String get key;
  @override
  String get value;

  /// Create a copy of ProfileEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileEntryImplCopyWith<_$ProfileEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
