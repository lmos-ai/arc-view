/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/settings/repositories/envs_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'env_notifier.g.dart';

@riverpod
class EnvNotifier extends _$EnvNotifier {
  @override
  List<String> build() {
    return ref.read(envsRepositoryProvider).fetch();
  }

  addEnv(String env) {
    state = ref.read(envsRepositoryProvider).add(env);
  }

  removeEnv(String env) {
    state = ref.read(envsRepositoryProvider).remove(env);
  }
}

extension EnvNotifierRef on WidgetRef {
  addEnv(String env) {
    read(envNotifierProvider.notifier).addEnv(env);
  }

  removeEnv(String env) {
    read(envNotifierProvider.notifier).removeEnv(env);
  }
}
