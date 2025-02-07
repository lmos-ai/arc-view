/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/tools/models/test_tool.dart';
import 'package:arc_view/src/tools/repositories/tools_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tools_notifier.g.dart';

///
/// Holds the use case that has been selected and is sent to the Agent.
///
@Riverpod(keepAlive: true)
class ToolsNotifier extends _$ToolsNotifier {
  @override
  List<TestTool> build() {
    final useCaseRepository = ref.read(toolsRepositoryProvider);
    return useCaseRepository.fetch();
  }

  newTool(TestTool testTool) {
    state = [...state, testTool];
    ref.read(toolsRepositoryProvider).save(state);
  }

  removeTool(TestTool tool) {
    state = state.where((e) => e != tool).toList();
    ref.read(toolsRepositoryProvider).save(state);
  }

  updateTool(TestTool testTool) {
    state = state.map((e) => e.id == testTool.id ? testTool : e).toList();
    ref.read(toolsRepositoryProvider).save(state);
  }
}
