/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_usecase_notifier.g.dart';

///
/// Holds the use case that has been selected and is sent to the Agent.
///
@Riverpod(keepAlive: true)
class SelectedUsecaseNotifier extends _$SelectedUsecaseNotifier {
  @override
  String? build() => null;

  setSelected(UseCase? useCase) {
    state = useCase?.name;
  }

  remove() {
    state = null;
  }
}
