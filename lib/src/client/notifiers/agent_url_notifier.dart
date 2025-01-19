/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_url_notifier.g.dart';

typedef AgentUrlData = ({Uri url, bool secure, String? agent});

@riverpod
class AgentUrlNotifier extends _$AgentUrlNotifier {
  @override
  AgentUrlData build() {
    final url = Uri.base.isScheme('http') || Uri.base.isScheme('https')
        ? '${Uri.base.scheme}://${Uri.base.host}:${Uri.base.port}'
        : 'http://localhost:8080';
    final secure = Uri.base.isScheme('https');
    return (url: Uri.parse(url), secure: secure, agent: null);
  }

  setUrl(String url) {
    final uri = Uri.parse(url);
    final secure = uri.isScheme('https');
    state = (
      url: uri,
      secure: secure,
      agent: state.agent,
    );
  }

  setAgent(String agent) {
    state = (
      url: state.url,
      secure: state.secure,
      agent: agent,
    );
  }
}
