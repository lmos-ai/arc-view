/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';
import 'dart:typed_data';

import 'package:arc_view/src/client/notifiers/agent_client_notifier.dart';
import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:audioplayers/audioplayers.dart';
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
      Conversation conversation, Uint8List data) async {
    if (conversation.messages.isEmpty) return const Stream.empty();
    final channel =
        WebSocketChannel.connect(Uri.parse('http://localhost:8080/ws/agent'));

    await channel.ready;
    final payload = {
      "agentName": agentUrl.agent ?? 'default',
      "payload": {
        "conversationContext": {
          "conversationId": conversation.conversationId,
          "anonymizationEntities": []
        },
        "systemContext": conversation.systemContext.entries
            .map((e) => {
                  'key': e.key,
                  'value': e.value,
                })
            .toList(),
        "userContext": conversation.userContext.toJson(),
        "messages": conversation.messages
            .where((e) => e.type != MessageType.loading)
            .map((e) => {
                  'content': e.content,
                  'role': e.type == MessageType.user ? 'user' : 'assistant',
                  'format': 'text',
                  'binaryData': e.binaryData
                })
            .toList(),
      }
    };
    channel.sink.add(jsonEncode(payload));
    channel.sink.add(data);
    channel.sink.add('<FIN>');

    _log.fine('Sent message: ${data.length}');

    return channel.stream.map((message) {
      final agent = agentUrl.agent ?? 'default';
      _log.fine('Received message: $message');

      if (message is String) {
        final jsonResult = jsonDecode(message);
        return (
          message: jsonResult['messages'][0]['content'],
          responseTime: -1,
          agent: agent,
          binaryData: null
        );
      } else {
        var player = AudioPlayer();
        player.setSourceBytes(message).then((a) {
          player.resume();
        });
        // TODO CLOSE PLAYER
      }
      return (
        message: null,
        responseTime: -1,
        agent: agent,
        binaryData: message
      );
    });
  }

  Future<bool> isConnected() async {
    return true;
  }

  close() async {}
}

typedef MessageResult = ({
  String? message,
  double? responseTime,
  String agent,
  Uint8List? binaryData
});
