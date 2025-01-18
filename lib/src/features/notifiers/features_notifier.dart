/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/features/models/feature.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'features_notifier.g.dart';

@riverpod
class FeaturesNotifier extends _$FeaturesNotifier {
  @override
  List<Feature> build() {
    return _getFeaturesFromQueryParam();
  }

  List<Feature> _getFeaturesFromQueryParam() {
    print(
        'FeaturesNotifier:  Uri.base.queryParameters: ${Uri.base}');
    print(
        'FeaturesNotifier:  Uri.base.queryParameters: ${Uri.base.hasQuery}');
    if (!Uri.base.hasQuery) return List.empty();
    List<Feature> features = [];
    Uri.base.queryParameters.forEach((key, value) {
      if (value == 'true') features.add(Feature(name: key));
    });
    print('FeaturesNotifier: $features');
    return features;
  }
}
