/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/oneai_stream_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_stream_client_notifier.g.dart';

typedef AgentUrlData = ({Uri url, bool secure, String? agent});

@Riverpod(keepAlive: true)
class AgentStreamClientNotifier extends _$AgentStreamClientNotifier {
  @override
  OneAIStreamClient build() {
    final url = Uri.base.isScheme('http')
        ? '${Uri.base.scheme}://${Uri.base.host}:${Uri.base.port}'
        : 'http://localhost:8080';
    final secure = Uri.base.isScheme('https');
    final client = OneAIStreamClient(
      (url: Uri.parse(url), secure: secure, agent: null),
    );
    ref.onDispose(() => client.close());
    return client;
  }

  setUrl(String url) {
    final uri = Uri.parse(url);
    final secure = uri.isScheme('https');
    state.close();
    state = OneAIStreamClient((
      url: uri,
      secure: secure,
      agent: state.agentUrl.agent,
    ));
  }

  setAgent(String agent) {
    state.close();
    state = OneAIStreamClient((
      url: state.agentUrl.url,
      secure: state.agentUrl.secure,
      agent: agent,
    ));
  }
}
