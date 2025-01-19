/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:arc_view/src/client/models/message.dart';
import 'package:arc_view/src/client/models/message_result.dart';
import 'package:arc_view/src/client/notifiers/agent_stream_client_notifier.dart';
import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OneAIStreamClient {
  OneAIStreamClient(this.agentUrl);

  final AgentUrlData agentUrl;
  WebSocketChannel? _channel;
  final _log = Logger('OneAIClient');

  Stream<MessageResult> sendMessage(
    Conversation conversation,
    Stream<Uint8List> data,
  ) {
    if (conversation.messages.isEmpty) return Stream.empty();
    final url =
        '${agentUrl.secure ? 'wss://' : 'ws://'}${agentUrl.url.host}:${agentUrl.url.port}/stream/agent';

    _log.fine('Connecting to $url...');
    _channel?.sink.close();
    final channel = WebSocketChannel.connect(Uri.parse(url));
    _channel = channel;
    // await _channel.ready;

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
    data.listen((d) {
      channel.sink.add(d);
    });
    //_channel.sink.add('<FIN>');

    _log.fine('Sent message');

    return channel.stream.map((message) {
      final agent = agentUrl.agent ?? 'default';

      if (message is String) {
        _log.fine('Received message: $message');
        final agentResult = AgentResult.fromJson(jsonDecode(message));
        return (
          messages: agentResult.messages,
          responseTime: agentResult.responseTime,
          agent: agent,
          error: null
        );
      } else {
        _log.fine('Received binary message');
        var player = AudioPlayer();
        player.setSourceBytes(message).then((a) {
          player.resume();
        });
        player.onPlayerStateChanged.listen((event) {
          if (event == PlayerState.completed) {
            player.dispose();
          }
        });
      }
      return (
        messages: List.empty(),
        responseTime: -1,
        agent: agent,
        error: null
      );
    });
  }

  Future<bool> isConnected() async {
    return _channel != null && _channel?.closeCode != null;
  }

  close() async {
    _channel?.sink.close();
  }
}
