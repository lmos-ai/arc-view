/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:arc_view/src/usecases/repositories/usecase_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecases_notifier.g.dart';

@riverpod
class UseCasesNotifier extends _$UseCasesNotifier {
  @override
  Future<UseCases> build() async {
    final useCaseRepository = ref.read(useCaseRepositoryProvider);
    return UseCases(selected: 0, cases: useCaseRepository.loadUseCases());
  }

  save() {
    final useCases = state.valueOrNull;
    if (useCases == null) return;
    final useCaseRepository = ref.read(useCaseRepositoryProvider);
    useCaseRepository.save(useCases);
  }

  setSelected(int index) {
    final useCases = state.valueOrNull;
    if (useCases != null) {
      state = AsyncData(useCases.copyWith(selected: index));
    }
  }

  void newUseCase() {
    final useCases = state.valueOrNull;
    if (useCases == null) return;
    final newUseCase = UseCase(
      name: 'New Use Case',
      date: DateTime.now(),
      content: '''
      ### Usecase: New Use Case
      #### Description
      Add description here.

      #### Solution 
      Add solution here.

      ----
    ''',
    );
    state =
        AsyncData(useCases.copyWith(cases: [newUseCase, ...useCases.cases]));
  }
}
