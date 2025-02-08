/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:math';

import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:arc_view/src/usecases/repositories/usecase_repository.dart';
import 'package:arc_view/src/usecases/usecase_template.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecases_notifier.g.dart';

///
/// Manages the creation and editing of Use Cases files.
///
@riverpod
class UseCasesNotifier extends _$UseCasesNotifier {
  @override
  Future<UseCases> build() async {
    final useCaseRepository = ref.read(useCaseRepositoryProvider);
    return UseCases(selected: 0, cases: useCaseRepository.fetch());
  }

  save() {
    final useCases = state.valueOrNull;
    if (useCases == null) return;
    final useCaseRepository = ref.read(useCaseRepositoryProvider);
    useCaseRepository.save(useCases);
  }

  setSelected(int index) {
    final useCases = state.valueOrNull;
    if (useCases == null) return;
    state = AsyncData(useCases.copyWith(selected: index));
  }

  newUseCase(String name, {String? content}) {
    final useCases = state.valueOrNull;
    if (useCases == null) return;
    final newUseCase = UseCase(
      id: '$name-${DateTime.now().millisecondsSinceEpoch}',
      name: name.isEmpty
          ? 'usecases'
          : name
              .replaceAll(' ', '_')
              .replaceAll(useCaseNameInvalidCharacters, ''),
      createdAt: DateTime.now(),
      content: content ?? useCaseTemplate,
    );
    _update([newUseCase, ...useCases.cases]);
  }

  deleteUseCaseAt(int index) {
    final useCases = state.valueOrNull;
    if (useCases == null) return;
    final toRemove = useCases.cases[index];
    _update(useCases.cases.where((e) => e != toRemove).toList());
  }

  addUseCase(String content) {
    final useCases = state.valueOrNull;
    if (useCases == null) return;
    final selected = useCases.selectedCase;
    if (selected == null) return;

    final updatedUseCase =
        selected.copyWith(content: '$content\n${selected.content}');
    _update(useCases.cases.map((e) {
      return e == selected ? updatedUseCase : e;
    }).toList());
  }

  updateSelected(String text) {
    final useCases = state.valueOrNull;
    if (useCases == null) return;
    final selected = useCases.selectedCase;
    if (selected == null) return;

    final updatedUseCase = selected.copyWith(content: text);
    _update(useCases.cases.map((e) {
      return e == selected ? updatedUseCase : e;
    }).toList());
  }

  _update(List<UseCase> updatedCases) {
    final useCases = state.valueOrNull;
    if (useCases == null) return;
    final selected = useCases.selected >= updatedCases.length
        ? max(0, updatedCases.length - 1)
        : useCases.selected;
    state = AsyncData(useCases.copyWith(
      cases: updatedCases,
      selected: selected,
    ));
    save();
  }
}
