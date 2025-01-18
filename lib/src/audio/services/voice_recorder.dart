/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:record/record.dart';

///
/// Starts and stops recording audio from the microphone.
///
class VoiceRecorder {
  // The configuration for the audio recording.
  // Must match the OpenAI Real-Time API requirements.
  final _recordConfig = const RecordConfig(
    numChannels: 1,
    sampleRate: 24000,
    encoder: AudioEncoder.pcm16bits,
  );

  final _record = AudioRecorder();

  ///
  /// Start recording audio from the microphone.
  ///
  Future<Uint8List?> startRecording() async {
    if (await _record.hasPermission()) {
      await _record.start(_recordConfig, path: 'audio.pcm');
      return Future.delayed(const Duration(seconds: 3), () async {
        final path = await _record.stop();
        final response = await http.get(Uri.parse(path!));
        Uint8List data = response.bodyBytes;
        _record.dispose();
        return data;
      });
    }
    return null;
  }

  ///
  /// Start recording audio from the microphone and streams the data.
  ///
  Future<Stream<Uint8List>?> startRecordingStream() async {
    if (await _record.hasPermission()) {
      final stream = await _record.startStream(_recordConfig);
      return stream;
    }
    return null;
  }

  ///
  /// Stop recording audio from the microphone.
  ///
  Future<void> stopRecording() async {
    await _record.stop();
  }
}
