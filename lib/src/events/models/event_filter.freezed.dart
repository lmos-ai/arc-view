// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventFilter {
  String get label => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  List<String>? get active => throw _privateConstructorUsedError;
  bool Function(AgentEvent, EventFilter) get match =>
      throw _privateConstructorUsedError;

  /// Create a copy of EventFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventFilterCopyWith<EventFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventFilterCopyWith<$Res> {
  factory $EventFilterCopyWith(
          EventFilter value, $Res Function(EventFilter) then) =
      _$EventFilterCopyWithImpl<$Res, EventFilter>;
  @useResult
  $Res call(
      {String label,
      List<String> options,
      List<String>? active,
      bool Function(AgentEvent, EventFilter) match});
}

/// @nodoc
class _$EventFilterCopyWithImpl<$Res, $Val extends EventFilter>
    implements $EventFilterCopyWith<$Res> {
  _$EventFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? options = null,
    Object? active = freezed,
    Object? match = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      match: null == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as bool Function(AgentEvent, EventFilter),
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventFilterImplCopyWith<$Res>
    implements $EventFilterCopyWith<$Res> {
  factory _$$EventFilterImplCopyWith(
          _$EventFilterImpl value, $Res Function(_$EventFilterImpl) then) =
      __$$EventFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String label,
      List<String> options,
      List<String>? active,
      bool Function(AgentEvent, EventFilter) match});
}

/// @nodoc
class __$$EventFilterImplCopyWithImpl<$Res>
    extends _$EventFilterCopyWithImpl<$Res, _$EventFilterImpl>
    implements _$$EventFilterImplCopyWith<$Res> {
  __$$EventFilterImplCopyWithImpl(
      _$EventFilterImpl _value, $Res Function(_$EventFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? options = null,
    Object? active = freezed,
    Object? match = null,
  }) {
    return _then(_$EventFilterImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      active: freezed == active
          ? _value._active
          : active // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      match: null == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as bool Function(AgentEvent, EventFilter),
    ));
  }
}

/// @nodoc

class _$EventFilterImpl extends _EventFilter {
  _$EventFilterImpl(
      {required this.label,
      required final List<String> options,
      final List<String>? active,
      required this.match})
      : _options = options,
        _active = active,
        super._();

  @override
  final String label;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  final List<String>? _active;
  @override
  List<String>? get active {
    final value = _active;
    if (value == null) return null;
    if (_active is EqualUnmodifiableListView) return _active;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool Function(AgentEvent, EventFilter) match;

  @override
  String toString() {
    return 'EventFilter(label: $label, options: $options, active: $active, match: $match)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventFilterImpl &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality().equals(other._active, _active) &&
            (identical(other.match, match) || other.match == match));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      label,
      const DeepCollectionEquality().hash(_options),
      const DeepCollectionEquality().hash(_active),
      match);

  /// Create a copy of EventFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventFilterImplCopyWith<_$EventFilterImpl> get copyWith =>
      __$$EventFilterImplCopyWithImpl<_$EventFilterImpl>(this, _$identity);
}

abstract class _EventFilter extends EventFilter {
  factory _EventFilter(
          {required final String label,
          required final List<String> options,
          final List<String>? active,
          required final bool Function(AgentEvent, EventFilter) match}) =
      _$EventFilterImpl;
  _EventFilter._() : super._();

  @override
  String get label;
  @override
  List<String> get options;
  @override
  List<String>? get active;
  @override
  bool Function(AgentEvent, EventFilter) get match;

  /// Create a copy of EventFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventFilterImplCopyWith<_$EventFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
