/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_usecase_notifier.g.dart';

///
/// Holds the use case that has been selected and is sent to the Agent.
///
@riverpod
class SelectedUsecaseNotifier extends _$SelectedUsecaseNotifier {
  @override
  UseCase? build() => null;

  setSelected(UseCase? useCase) {
    state = useCase;
  }

  remove() {
    state = null;
  }
}
