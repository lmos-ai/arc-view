/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OnSaveCallback = void Function(String);

class ContextField extends StatefulWidget {
  const ContextField(
    this.label,
    this.text, {
    super.key,
    required this.onSave,
    required this.onChanged,
  });

  final String label;
  final String text;
  final OnSaveCallback onSave;
  final ValueChanged onChanged;

  @override
  State<ContextField> createState() => _ContextFieldState();
}

class _ContextFieldState extends State<ContextField> {
  late TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      _textController.text = widget.text;

      return TextFormField(
        controller: _textController,
        onChanged: widget.onChanged,
        onSaved: (value) {
          if (value == null) return;
          widget.onSave(value);
        },
        validator: (value) {
          try {
            jsonDecode(value ?? "");
          } catch (e) {
            return "Invalid JSON";
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.label,
        ),
        maxLines: 10,
      );
    });
  }

  @override
  initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  dispose() {
    _textController.dispose();
    super.dispose();
  }
}
