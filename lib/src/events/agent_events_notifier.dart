/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:async';

import 'package:arc_view/src/client/agent_client_notifier.dart';
import 'package:arc_view/src/events/agent_events.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_events_notifier.g.dart';

@riverpod
class AgentEventsNotifier extends _$AgentEventsNotifier {
  StreamSubscription? _lastSubscription;

  @override
  List<AgentEvent> build() {
    final client = ref.watch(agentClientNotifierProvider);
    _lastSubscription?.cancel();
    _lastSubscription = null;

    client.isConnected().then((connected) {
      if (!connected) return;
      _lastSubscription = client.listenToEvents().listen((e) {
        if (e == null) return;
        state = [e, ...state];
      });
    });
    ref.onDispose(() {
      _lastSubscription?.cancel();
    });
    return List.empty();
  }

  reset() {
    state = build();
  }
}
