/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:flutter/material.dart';

class TextInputDialog extends StatefulWidget {
  const TextInputDialog({
    super.key,
    required this.onConfirm,
    required this.title,
    this.value,
    this.hintText,
    this.actionText,
  });

  final String title;
  final String? value;
  final String? hintText;
  final String? actionText;
  final Function(String) onConfirm;

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<TextInputDialog> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      _textController.text = widget.value!;
    }
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _textController,
        decoration: InputDecoration(
          hintText: widget.hintText,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(widget.actionText ?? 'OK'),
          onPressed: () {
            widget.onConfirm(_textController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
