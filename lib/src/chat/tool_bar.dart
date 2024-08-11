import 'package:arc_view/src/conversation/conversation_exporter.dart';
import 'package:arc_view/src/conversation/conversation_importer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToolBar extends ConsumerWidget {
  const ToolBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            ref.read(conversationImporterProvider).load();
          },
          icon: Icon(
            Icons.upload,
            size: 16,
            color: colorScheme.onSurface,
          ),
        ),
        IconButton(
          onPressed: () {
            ref.read(conversationExporterProvider).export();
          },
          icon: Icon(
            Icons.download,
            size: 16,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
