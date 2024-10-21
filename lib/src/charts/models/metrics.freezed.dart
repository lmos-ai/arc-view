// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Metrics {
  Color get color => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get conversationId => throw _privateConstructorUsedError;
  Map<PlotType, List<Plot>> get plots => throw _privateConstructorUsedError;

  /// Create a copy of Metrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MetricsCopyWith<Metrics> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetricsCopyWith<$Res> {
  factory $MetricsCopyWith(Metrics value, $Res Function(Metrics) then) =
      _$MetricsCopyWithImpl<$Res, Metrics>;
  @useResult
  $Res call(
      {Color color,
      String name,
      String? conversationId,
      Map<PlotType, List<Plot>> plots});
}

/// @nodoc
class _$MetricsCopyWithImpl<$Res, $Val extends Metrics>
    implements $MetricsCopyWith<$Res> {
  _$MetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Metrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = null,
    Object? name = null,
    Object? conversationId = freezed,
    Object? plots = null,
  }) {
    return _then(_value.copyWith(
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String?,
      plots: null == plots
          ? _value.plots
          : plots // ignore: cast_nullable_to_non_nullable
              as Map<PlotType, List<Plot>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MetricsImplCopyWith<$Res> implements $MetricsCopyWith<$Res> {
  factory _$$MetricsImplCopyWith(
          _$MetricsImpl value, $Res Function(_$MetricsImpl) then) =
      __$$MetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Color color,
      String name,
      String? conversationId,
      Map<PlotType, List<Plot>> plots});
}

/// @nodoc
class __$$MetricsImplCopyWithImpl<$Res>
    extends _$MetricsCopyWithImpl<$Res, _$MetricsImpl>
    implements _$$MetricsImplCopyWith<$Res> {
  __$$MetricsImplCopyWithImpl(
      _$MetricsImpl _value, $Res Function(_$MetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Metrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = null,
    Object? name = null,
    Object? conversationId = freezed,
    Object? plots = null,
  }) {
    return _then(_$MetricsImpl(
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String?,
      plots: null == plots
          ? _value._plots
          : plots // ignore: cast_nullable_to_non_nullable
              as Map<PlotType, List<Plot>>,
    ));
  }
}

/// @nodoc

class _$MetricsImpl implements _Metrics {
  _$MetricsImpl(
      {required this.color,
      required this.name,
      this.conversationId,
      required final Map<PlotType, List<Plot>> plots})
      : _plots = plots;

  @override
  final Color color;
  @override
  final String name;
  @override
  final String? conversationId;
  final Map<PlotType, List<Plot>> _plots;
  @override
  Map<PlotType, List<Plot>> get plots {
    if (_plots is EqualUnmodifiableMapView) return _plots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_plots);
  }

  @override
  String toString() {
    return 'Metrics(color: $color, name: $name, conversationId: $conversationId, plots: $plots)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetricsImpl &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            const DeepCollectionEquality().equals(other._plots, _plots));
  }

  @override
  int get hashCode => Object.hash(runtimeType, color, name, conversationId,
      const DeepCollectionEquality().hash(_plots));

  /// Create a copy of Metrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MetricsImplCopyWith<_$MetricsImpl> get copyWith =>
      __$$MetricsImplCopyWithImpl<_$MetricsImpl>(this, _$identity);
}

abstract class _Metrics implements Metrics {
  factory _Metrics(
      {required final Color color,
      required final String name,
      final String? conversationId,
      required final Map<PlotType, List<Plot>> plots}) = _$MetricsImpl;

  @override
  Color get color;
  @override
  String get name;
  @override
  String? get conversationId;
  @override
  Map<PlotType, List<Plot>> get plots;

  /// Create a copy of Metrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MetricsImplCopyWith<_$MetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Plot {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;

  /// Create a copy of Plot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlotCopyWith<Plot> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlotCopyWith<$Res> {
  factory $PlotCopyWith(Plot value, $Res Function(Plot) then) =
      _$PlotCopyWithImpl<$Res, Plot>;
  @useResult
  $Res call({double x, double y});
}

/// @nodoc
class _$PlotCopyWithImpl<$Res, $Val extends Plot>
    implements $PlotCopyWith<$Res> {
  _$PlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Plot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlotImplCopyWith<$Res> implements $PlotCopyWith<$Res> {
  factory _$$PlotImplCopyWith(
          _$PlotImpl value, $Res Function(_$PlotImpl) then) =
      __$$PlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x, double y});
}

/// @nodoc
class __$$PlotImplCopyWithImpl<$Res>
    extends _$PlotCopyWithImpl<$Res, _$PlotImpl>
    implements _$$PlotImplCopyWith<$Res> {
  __$$PlotImplCopyWithImpl(_$PlotImpl _value, $Res Function(_$PlotImpl) _then)
      : super(_value, _then);

  /// Create a copy of Plot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$PlotImpl(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$PlotImpl implements _Plot {
  _$PlotImpl({required this.x, required this.y});

  @override
  final double x;
  @override
  final double y;

  @override
  String toString() {
    return 'Plot(x: $x, y: $y)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlotImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  /// Create a copy of Plot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlotImplCopyWith<_$PlotImpl> get copyWith =>
      __$$PlotImplCopyWithImpl<_$PlotImpl>(this, _$identity);
}

abstract class _Plot implements Plot {
  factory _Plot({required final double x, required final double y}) =
      _$PlotImpl;

  @override
  double get x;
  @override
  double get y;

  /// Create a copy of Plot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlotImplCopyWith<_$PlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
