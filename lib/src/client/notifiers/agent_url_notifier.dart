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
    final base = _getBaseUrl();
    final url = base.isScheme('http') || base.isScheme('https')
        ? '${base.scheme}://${base.host}:${base.port}'
        : 'http://localhost:8080';
    final secure = base.isScheme('https');
    return (url: Uri.parse(url), secure: secure, agent: null);
  }

  Uri _getBaseUrl() {
    try {
      if (!Uri.base.hasQuery) return Uri.base;
      final url = Uri.base.queryParameters['agentUrl'];
      if (url == null) return Uri.base;
      return Uri.parse(url);
    } catch (_) {}
    return Uri.base;
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
