/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/audio/notifiers/voice_notifier.dart';
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
// Starts the recording of the voice message.
//
class RecordButton extends ConsumerWidget {
  const RecordButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SecondaryButton(
      description: 'Record voice',
      icon: VoiceStatus.recording == ref.watch(voiceNotifierProvider)
          ? Icons.mic_off
          : Icons.mic,
      onPressed: () async {
        final status = ref.read(voiceNotifierProvider);
        if (VoiceStatus.idle == status) {
          ref.read(voiceNotifierProvider.notifier).startRecording();
        } else {
          ref.read(voiceNotifierProvider.notifier).stopRecording();
        }
      },
    );
  }
}
