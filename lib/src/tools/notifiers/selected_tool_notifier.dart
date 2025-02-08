/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/tools/models/test_tool.dart';
import 'package:arc_view/src/tools/notifiers/tools_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_tool_notifier.g.dart';

///
/// Holds the use case that has been selected and is sent to the Agent.
///
@Riverpod(keepAlive: true)
class SelectedToolNotifier extends _$SelectedToolNotifier {
  @override
  Set<TestTool> build() {
    ref.listen(toolsNotifierProvider, (_, tools) {
      if (state.isNotEmpty) {
        state = tools.where((t) => isSelected(t)).toSet();
      }
    });
    return {};
  }

  select(TestTool testTool) {
    state = {...state, testTool};
  }

  clear() {
    state = {};
  }

  deselect(TestTool testTool) {
    state = state.where((e) => e.id != testTool.id).toSet();
  }

  bool isSelected(TestTool testTool) {
    return state.where((e) => e.id == testTool.id).isNotEmpty;
  }
}
