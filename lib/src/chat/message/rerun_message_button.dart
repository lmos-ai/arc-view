import 'package:arc_view/src/conversation/conversations.dart';
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
        ref.read(conversationsProvider.notifier).addUserMessage(_text);
      },
    );
  }
}
