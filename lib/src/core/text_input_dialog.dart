/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:flutter/material.dart';

class TextInputDialog extends StatefulWidget {
  final String title;
  final String hintText;
  final Function(String) onConfirm;

  const TextInputDialog({
    super.key,
    required this.title,
    required this.hintText,
    required this.onConfirm,
  });

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<TextInputDialog> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          child: const Text('OK'),
          onPressed: () {
            widget.onConfirm(_textController.text);

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
