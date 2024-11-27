// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Conversations {
  List<Conversation> get conversations => throw _privateConstructorUsedError;
  Conversation get current => throw _privateConstructorUsedError;

  /// Create a copy of Conversations
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationsCopyWith<Conversations> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationsCopyWith<$Res> {
  factory $ConversationsCopyWith(
          Conversations value, $Res Function(Conversations) then) =
      _$ConversationsCopyWithImpl<$Res, Conversations>;
  @useResult
  $Res call({List<Conversation> conversations, Conversation current});

  $ConversationCopyWith<$Res> get current;
}

/// @nodoc
class _$ConversationsCopyWithImpl<$Res, $Val extends Conversations>
    implements $ConversationsCopyWith<$Res> {
  _$ConversationsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Conversations
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversations = null,
    Object? current = null,
  }) {
    return _then(_value.copyWith(
      conversations: null == conversations
          ? _value.conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as Conversation,
    ) as $Val);
  }

  /// Create a copy of Conversations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConversationCopyWith<$Res> get current {
    return $ConversationCopyWith<$Res>(_value.current, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConversationsImplCopyWith<$Res>
    implements $ConversationsCopyWith<$Res> {
  factory _$$ConversationsImplCopyWith(
          _$ConversationsImpl value, $Res Function(_$ConversationsImpl) then) =
      __$$ConversationsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Conversation> conversations, Conversation current});

  @override
  $ConversationCopyWith<$Res> get current;
}

/// @nodoc
class __$$ConversationsImplCopyWithImpl<$Res>
    extends _$ConversationsCopyWithImpl<$Res, _$ConversationsImpl>
    implements _$$ConversationsImplCopyWith<$Res> {
  __$$ConversationsImplCopyWithImpl(
      _$ConversationsImpl _value, $Res Function(_$ConversationsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Conversations
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversations = null,
    Object? current = null,
  }) {
    return _then(_$ConversationsImpl(
      conversations: null == conversations
          ? _value._conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as Conversation,
    ));
  }
}

/// @nodoc

class _$ConversationsImpl extends _Conversations {
  _$ConversationsImpl(
      {required final List<Conversation> conversations, required this.current})
      : _conversations = conversations,
        super._();

  final List<Conversation> _conversations;
  @override
  List<Conversation> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  final Conversation current;

  @override
  String toString() {
    return 'Conversations(conversations: $conversations, current: $current)';
  }

  /// Create a copy of Conversations
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationsImplCopyWith<_$ConversationsImpl> get copyWith =>
      __$$ConversationsImplCopyWithImpl<_$ConversationsImpl>(this, _$identity);
}

abstract class _Conversations extends Conversations {
  factory _Conversations(
      {required final List<Conversation> conversations,
      required final Conversation current}) = _$ConversationsImpl;
  _Conversations._() : super._();

  @override
  List<Conversation> get conversations;
  @override
  Conversation get current;

  /// Create a copy of Conversations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationsImplCopyWith<_$ConversationsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
