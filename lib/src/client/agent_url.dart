/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_url.g.dart';

typedef AgentUrlData = (Uri url, {bool secure});

@riverpod
class AgentUrl extends _$AgentUrl {
  @override
  AgentUrlData build() => (Uri.parse('http://localhost:8090'), secure: false);

  setUrl(String url) {
    final uri = Uri.parse(url);
    final secure = uri.isScheme('https');
    state = (uri, secure: secure);
  }
}
