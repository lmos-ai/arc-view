/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'use_cases.freezed.dart';
part 'use_cases.g.dart';

/// The characters that are not allowed in a use case name.
final useCaseNameInvalidCharacters = RegExp(r'[^a-zA-Z0-9_-]');

/// A collection of use cases where one use case can be selected.
@freezed
class UseCases with _$UseCases {
  factory UseCases({
    required List<UseCase> cases,
    required int selected,
  }) = _UseCases;

  UseCases._();

  UseCase? get selectedCase => (cases.isEmpty) ? null : cases[selected];

  factory UseCases.fromJson(Map<String, dynamic> json) =>
      _$UseCasesFromJson(json);
}

@freezed
class UseCase with _$UseCase {
  factory UseCase({
    required String name,
    required DateTime createdAt,
    required String content,
  }) = _UseCase;

  UseCase._();

  static final useCaseSplitRegex = RegExp(r'(?=###\s*UseCase\s*:\s*)');

  List<(String, String)> splitContent() {
    return content.split(useCaseSplitRegex).map((e) {
      final name = e.substring(0, e.indexOf('\n')).trim().replaceAll('#', '');
      return (name, e);
    }).toList();
  }

  factory UseCase.fromJson(Map<String, dynamic> json) =>
      _$UseCaseFromJson(json);
}
