/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:typed_data';

import 'package:arc_view/src/client/models/system_context.dart';
import 'package:arc_view/src/client/models/user_context.dart';
import 'package:arc_view/src/client/notifiers/agent_ws_client_notifier.dart';
import 'package:arc_view/src/client/notifiers/agents_notifier.dart';
import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:record/record.dart';
import 'package:smiles/smiles.dart';
import 'package:web/web.dart' as web;

class RecordButton extends ConsumerWidget {
  const RecordButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return 'Record'.onButtonPressed(disabled: false, () async {
      final record = AudioRecorder();
      if (await record.hasPermission()) {
        // Start recording to file
        await record.start(
            const RecordConfig(
                numChannels: 1,
                sampleRate: 24000,
                encoder: AudioEncoder.pcm16bits),
            path: 'audio.wav');
        // ... or to stream
        //final stream = await record
        //   .startStream(const RecordConfig(encoder: AudioEncoder.wav));

        Future.delayed(const Duration(seconds: 3), () async {
          // Stop recording...
          final path = await record.stop();

          final response = await http.get(
            Uri.parse(path!),
          );
          Uint8List data = response.bodyBytes;

          final stream =
              await ref.read(agentWSClientNotifierProvider).sendMessage(
                    Conversation(
                        createdAt: DateTime.now(),
                        conversationId: '1234',
                        messages: [
                          ConversationMessage(
                              conversationId: '1234',
                              content: 'User input',
                              type: MessageType.user,
                              binaryData: [
                                BinaryData(
                                  data: 'stream',
                                  mimeType: 'audio/wav',
                                )
                              ])
                        ],
                        systemContext: SystemContext(entries: List.empty()),
                        userContext:
                            UserContext(userId: '1234', profile: List.empty())),
                    data,
                  );
          stream.listen((event) {
            print('Received event: $event');
          });

          record.dispose();
        });
      }
    }, tooltip: 'Send the current message');
  }

  void downloadWebData(String path) {
    // Simple download code for web testing
    final anchor = web.document.createElement('a') as web.HTMLAnchorElement
      ..href = path
      ..style.display = 'none'
      ..download = 'audio.wav';
    web.document.body!.appendChild(anchor);
    anchor.click();
    web.document.body!.removeChild(anchor);
  }

  _agentAvailable(WidgetRef ref) {
    final agents = ref.watch(agentsNotifierProvider);
    return agents.hasValue && agents.value?.names.isNotEmpty == true;
  }
}
