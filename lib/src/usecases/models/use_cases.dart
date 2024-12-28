/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'use_cases.freezed.dart';
part 'use_cases.g.dart';

@freezed
class UseCases with _$UseCases {
  factory UseCases({
    required List<UseCase> cases,
    required int selected,
  }) = _UseCases;

  UseCases._();

  get selectedCase => cases[selected];

  factory UseCases.fromJson(Map<String, dynamic> json) =>
      _$UseCasesFromJson(json);
}

@freezed
class UseCase with _$UseCase {
  factory UseCase({
    required String name,
    required DateTime date,
    required String content,
  }) = _UseCase;

  factory UseCase.fromJson(Map<String, dynamic> json) =>
      _$UseCaseFromJson(json);
}
