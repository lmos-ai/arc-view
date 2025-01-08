/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/chat/services/message_sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RerunMessageButton extends ConsumerWidget {
  const RerunMessageButton(this._text, {super.key});

  final String _text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.refresh, size: 16),
      onPressed: () {
        ref.read(messageSenderProvider).sendUserMessage(_text);
      },
    );
  }
}
