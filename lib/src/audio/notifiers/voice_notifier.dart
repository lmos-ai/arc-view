/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:typed_data';

import 'package:arc_view/src/audio/services/voice_recorder.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'voice_notifier.g.dart';

@riverpod
class VoiceNotifier extends _$VoiceNotifier {
  VoiceRecorder? _voiceRecorder;

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
    // await ref.read(conversationsNotifierProvider.notifier).addUserVoice(data);
    stopRecording();
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
