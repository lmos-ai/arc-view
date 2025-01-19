/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/notifiers/agent_url_notifier.dart';
import 'package:arc_view/src/client/oneai_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_client_notifier.g.dart';

@Riverpod(keepAlive: true)
class AgentClientNotifier extends _$AgentClientNotifier {
  @override
  OneAIClient build() {
    final agentUrl = ref.watch(agentUrlNotifierProvider);
    final client = OneAIClient(agentUrl);
    ref.onDispose(() => client.close());
    return client;
  }
}
