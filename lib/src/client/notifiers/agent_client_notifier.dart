/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/oneai_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_client_notifier.g.dart';

typedef AgentUrlData = ({Uri url, bool secure, String? agent});

@Riverpod(keepAlive: true)
class AgentClientNotifier extends _$AgentClientNotifier {
  @override
  OneAIClient build() {
    final url = Uri.base.isScheme('http') || Uri.base.isScheme('https')
        ? '${Uri.base.scheme}://${Uri.base.host}:${Uri.base.port}'
        : 'http://localhost:8080';
    final client = OneAIClient(
      (url: Uri.parse(url), secure: false, agent: null),
    );
    ref.onDispose(() => client.close());
    return client;
  }

  setUrl(String url) {
    final uri = Uri.parse(url);
    final secure = uri.isScheme('https');
    state.close();
    state = OneAIClient((
      url: uri,
      secure: secure,
      agent: state.agentUrl.agent,
    ));
  }

  setAgent(String agent) {
    state.close();
    state = OneAIClient((
      url: state.agentUrl.url,
      secure: state.agentUrl.secure,
      agent: agent,
    ));
  }
}
