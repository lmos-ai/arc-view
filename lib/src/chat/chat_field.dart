/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/notifiers/agents_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatField extends ConsumerWidget {
  const ChatField({super.key, required this.controller, this.onSubmitted});

  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentAvailable = _agentAvailable(ref);
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      enabled: agentAvailable,
      decoration: const InputDecoration(),
      keyboardType: TextInputType.multiline,
      maxLines: 2,
    );
  }

  _agentAvailable(WidgetRef ref) {
    final agents = ref.watch(agentsNotifierProvider);
    return agents.hasValue && agents.value?.names.isNotEmpty == true;
  }
}