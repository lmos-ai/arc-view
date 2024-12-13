/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:record/record.dart';

class VoiceRecorder {
  Future<Uint8List?> startRecording() async {
    final record = AudioRecorder();

    if (await record.hasPermission()) {
      await record.start(
          const RecordConfig(
              numChannels: 1,
              sampleRate: 24000,
              encoder: AudioEncoder.pcm16bits),
          path: 'audio.wav');
      // ... or to stream
      //final stream = await record
      //   .startStream(const RecordConfig(encoder: AudioEncoder.wav));

      return Future.delayed(const Duration(seconds: 3), () async {
        final path = await record.stop();
        final response = await http.get(Uri.parse(path!));
        Uint8List data = response.bodyBytes;
        record.dispose();
        return data;
      });
    }
    return null;
  }
}
