/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:async';
import 'dart:typed_data';

import 'package:arc_view/src/audio/services/voice_recorder.dart';
import 'package:arc_view/src/client/models/message_result.dart';
import 'package:arc_view/src/client/notifiers/agent_stream_client_notifier.dart';
import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:arc_view/src/conversation/notifiers/conversations_notifier.dart';
import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'voice_notifier.g.dart';

@riverpod
class VoiceNotifier extends _$VoiceNotifier {
  VoiceRecorder? _voiceRecorder;

  final _log = Logger('VoiceNotifier');

  @override
  VoiceStatus build() {
    ref.onDispose(() {
      stopRecording();
    });
    return VoiceStatus.idle;
  }

  playAudio(Uint8List audio) {
    var player = AudioPlayer();
    player.setSourceBytes(audio).then((a) {
      player.resume();
    });
    player.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        player.dispose();
      }
    });
  }

  startRecording() async {
    _voiceRecorder = VoiceRecorder();
    final data = await _voiceRecorder?.startRecordingStream();
    if (data == null) return;
    state = VoiceStatus.recording;
    _log.fine('Recording started');
    await _streamVoiceToBot('voice message', data);
    stopRecording();
  }

  Future<void> _streamVoiceToBot(String msg, Stream<Uint8List> data,
      {UseCase? useCase}) {
    final callback = Completer();
    final conversation = ref.read(conversationsNotifierProvider).current;

    var loadingConversation =
        ref.addUserRequest(msg, conversation, streamAudio: true);

    _streamAudio(loadingConversation.addUseCase(useCase), data).listen((value) {
      loadingConversation = ref.addBotResponse(value, loadingConversation);
      if (!callback.isCompleted) callback.complete();
    });
    return callback.future;
  }

  Stream<MessageResult> _streamAudio(
    Conversation conversation,
    Stream<Uint8List> data,
  ) {
    return ref
        .read(agentStreamClientNotifierProvider)
        .sendMessage(conversation, data);
  }

  stopRecording() async {
    await _voiceRecorder?.stopRecording();
    state = VoiceStatus.idle;
  }
}

enum VoiceStatus {
  idle,
  recording,
  error,
}
