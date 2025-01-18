/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/features/models/feature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'features.freezed.dart';

@freezed
class Features with _$Features {
  factory Features({
    required List<Feature> seatures,
  }) = _Features;

  const Features._();
}
