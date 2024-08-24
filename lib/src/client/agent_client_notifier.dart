/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/oneai_client.dart';
import 'package:arc_view/src/conversation/conversation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_client_notifier.g.dart';

typedef AgentUrlData = (Uri url, {bool secure});

@Riverpod(keepAlive: true)
class AgentClientNotifier extends _$AgentClientNotifier {
  @override
  OneAIClient build() {
    return OneAIClient((
        Uri.parse('http://localhost:8090'),
        secure: false,
      ));
  }

  setUrl(String url) {
    final uri = Uri.parse(url);
    final secure = uri.isScheme('https');
    state = OneAIClient((uri, secure: secure));
  }
}
