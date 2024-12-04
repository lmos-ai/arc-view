/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/notifiers/agent_client_notifier.dart';
import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OneAIWSClient {
  OneAIWSClient(this.agentUrl);

  final AgentUrlData agentUrl;
  final _log = Logger('OneAIClient');

  Future<List<String>> getAgents() async {
    return ['voice-agent'];
  }

  Future<Stream<MessageResult>> sendMessage(
      Conversation conversation, data) async {
    if (conversation.messages.isEmpty) return const Stream.empty();
    final channel =
        WebSocketChannel.connect(Uri.parse('ws://localhost:8080/ws/agent'));

    await channel.ready;

    print(23);
    channel.sink.add('''
        {
          "agentName": "${agentUrl.agent ?? 'default'}",
          "payload": {
              "messages": [],
              "conversationContext": {
                  "conversationId": "${conversation.conversationId}"
              }
           }
        }
    ''');
    channel.sink.add(data);
    return channel.stream.map((message) {
      final agent = agentUrl.agent ?? 'default';
      _log.fine('Received message: $message');
      return (message: message.toString(), responseTime: -1, agent: agent);
    });
  }

  Future<bool> isConnected() async {
    return true;
  }

  close() async {}
}

typedef MessageResult = ({String message, double? responseTime, String agent});
