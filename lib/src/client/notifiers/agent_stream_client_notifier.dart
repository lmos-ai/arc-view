/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/notifiers/agent_url_notifier.dart';
import 'package:arc_view/src/client/oneai_stream_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_stream_client_notifier.g.dart';

typedef AgentUrlData = ({Uri url, bool secure, String? agent});

@Riverpod(keepAlive: true)
class AgentStreamClientNotifier extends _$AgentStreamClientNotifier {
  @override
  OneAIStreamClient build() {
    final agentUrl = ref.watch(agentUrlNotifierProvider);
    final client = OneAIStreamClient(agentUrl);
    ref.onDispose(() => client.close());
    return client;
  }
}
