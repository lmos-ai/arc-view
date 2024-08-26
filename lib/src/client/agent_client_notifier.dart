/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/oneai_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_client_notifier.g.dart';

typedef AgentUrlData = ({Uri url, bool secure, String? agent});

@Riverpod(keepAlive: true)
class AgentClientNotifier extends _$AgentClientNotifier {
  @override
  OneAIClient build() {
    return OneAIClient((
      url: Uri.parse('http://localhost:8090'),
      secure: false,
      agent: null,
    ));
  }

  setUrl(String url) {
    final uri = Uri.parse(url);
    final secure = uri.isScheme('https');
    state = OneAIClient((
      url: uri,
      secure: secure,
      agent: state.agentUrl.agent,
    ));
  }

  setAgent(String agent) {
    state = OneAIClient((
      url: state.agentUrl.url,
      secure: state.agentUrl.secure,
      agent: agent,
    ));
  }
}
