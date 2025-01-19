/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/notifiers/agent_client_notifier.dart';
import 'package:arc_view/src/client/notifiers/agent_url_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agents_notifier.g.dart';

typedef Agents = ({String? activated, List<String> names});

@riverpod
class AgentsNotifier extends _$AgentsNotifier {
  @override
  Future<Agents> build() async {
    final client = ref.watch(agentClientNotifierProvider);
    final agents = await client.getAgents();
    final activated = client.agentUrl.agent;
    return (activated: activated, names: agents);
  }

  setActivated(String activated, List<String> names) {
    state = AsyncData((activated: activated, names: names));
    ref.read(agentUrlNotifierProvider.notifier).setAgent(activated);
  }

  refresh() async {
    state = AsyncData(await build());
  }
}

/// Extensions for the AgentsNotifier.
extension AgentsNotifierExtension on WidgetRef {
  activateAgent(String activated, List<String> names) {
    read(agentsNotifierProvider.notifier).setActivated(activated, names);
  }

  refreshAgents() {
    read(agentsNotifierProvider.notifier).refresh();
  }
}
