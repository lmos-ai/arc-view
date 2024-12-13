/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:record/record.dart';

class VoiceRecorder {
  final _recordConfig = const RecordConfig(
    numChannels: 1,
    sampleRate: 24000,
    encoder: AudioEncoder.pcm16bits,
  );

  final _record = AudioRecorder();

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

  Future<Stream<Uint8List>?> startRecordingStream() async {
    if (await _record.hasPermission()) {
      final stream = await _record.startStream(_recordConfig);
      return stream;
    }
    return null;
  }

  Future<void> stopRecording() async {
    await _record.stop();
  }
}
