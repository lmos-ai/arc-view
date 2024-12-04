/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/oneai_client.dart';
import 'package:arc_view/src/client/oneai_ws_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_ws_client_notifier.g.dart';

typedef AgentUrlData = ({Uri url, bool secure, String? agent});

@Riverpod(keepAlive: true)
class AgentWSClientNotifier extends _$AgentWSClientNotifier {
  @override
  OneAIWSClient build() {
    final url = Uri.base.isScheme('http')
        ? '${Uri.base.scheme}://${Uri.base.host}:${Uri.base.port}'
        : 'http://localhost:8080';
    final client = OneAIWSClient(
      (url: Uri.parse(url), secure: false, agent: null),
    );
    ref.onDispose(() => client.close());
    return client;
  }

  setUrl(String url) {}

  setAgent(String agent) {}
}
