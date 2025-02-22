/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';

typedef UseCaseDetails = ({String name, String description, List<String> tags});

///
/// Dialog for creating or editing UseCase details, such as name and description.
///
class UseCaseDialog extends StatefulWidget {
  const UseCaseDialog({
    super.key,
    required this.onConfirm,
    required this.title,
    this.value,
    this.actionText,
  });

  final String title;
  final UseCase? value;
  final String? actionText;
  final Function(UseCaseDetails) onConfirm;

  @override
  UseCaseDialogState createState() => UseCaseDialogState();
}

class UseCaseDialogState extends State<UseCaseDialog> {
  final _textController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      _textController.text = widget.value!.name;
      _tagsController.text = widget.value!.tags?.join(',') ?? '';
      _descriptionController.text = widget.value?.description ?? '';
    }
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Name',
            ),
          ),
          TextField(
            controller: _tagsController,
            decoration: InputDecoration(
              hintText: 'Tags (comma separated)',
            ),
          ),
          VGap.small(),
          ColoredBox(
            color: context.colorScheme.surface,
            child: TextField(
              controller: _descriptionController,
              maxLines: 8,
              minLines: 4,
              decoration: InputDecoration(
                hintText: 'Description',
              ),
            ).padByUnits(1, 1, 1, 1).size(width: 400),
          ),
        ],
      ).max(height: 400, width: 880),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(widget.actionText ?? 'OK'),
          onPressed: () {
            widget.onConfirm((
              name: _textController.text,
              description: _descriptionController.text,
              tags: _tagsController.text
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList(),
            ));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }
}
