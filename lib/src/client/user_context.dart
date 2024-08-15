import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_context.freezed.dart';
part 'user_context.g.dart';

@freezed
class UserContext with _$UserContext {
  factory UserContext({
    required String userId,
    String? userToken,
  }) = _UserContext;

  factory UserContext.fromJson(Map<String, Object?> json) =>
      _$UserContextFromJson(json);
}
