import 'package:arc_view/src/export/conversation_exporter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToolBar extends ConsumerWidget {
  const ToolBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationExporter = ref.watch(conversationExporterProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              conversationExporter.export();
            },
            icon: Icon(
              Icons.download,
              size: 16,
              color: Colors.black.withOpacity(0.5),
            )),
      ],
    );
  }
}
