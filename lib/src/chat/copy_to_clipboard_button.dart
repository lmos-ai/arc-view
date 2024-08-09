import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyToClipBoardButton extends StatelessWidget {
  const CopyToClipBoardButton(this._text, {super.key});

  final String _text;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.copy, size: 12),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: _text)).then((_) {
          //if (context.mounted) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text("Copied to clipboard")));
          // }
        });
      },
    );
  }
}
