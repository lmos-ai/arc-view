/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature.freezed.dart';

@freezed
class Feature with _$Feature {
  factory Feature({
    required String name,
  }) = _Feature;

  const Feature._();
}
