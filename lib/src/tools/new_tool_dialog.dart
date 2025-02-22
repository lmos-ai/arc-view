/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */
import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/tools/models/test_tool.dart';
import 'package:arc_view/src/tools/notifiers/tools_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class NewToolDialog extends StatefulWidget {
  const NewToolDialog({super.key, this.tool});

  final TestTool? tool;

  @override
  _NewToolDialogState createState() => _NewToolDialogState();
}

class _NewToolDialogState extends State<NewToolDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  final _titleController = TextEditingController();

  final _params = <(TextEditingController, TextEditingController)>[];

  @override
  void initState() {
    if (widget.tool != null) {
      _nameController.text = widget.tool!.name;
      _descriptionController.text = widget.tool!.description;
      _valueController.text = widget.tool!.value;
      _titleController.text = widget.tool!.title;
      _params.clear();
      _params.addAll(
        widget.tool!.parameters
            .map(
              (e) => (
                TextEditingController(text: e.name),
                TextEditingController(text: e.description)
              ),
            )
            .toList(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: (widget.tool != null)
          ? 'Edit Test Tool'.txt
          : 'Add New Test Tool'.txt,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'Tool Title (For display only)',
            ),
          ),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Tool Name (Example: get_bill)',
            ),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              hintText: 'Tool Description',
            ),
          ),
          VGap.small(),
          'Add Parameter'.onPressed(() {
            setState(() {
              _params.add((
                TextEditingController(),
                TextEditingController(),
              ));
            });
          }).toRight(),
          for (var i = 0; i < _params.length; i++)
            [
              TextField(
                controller: _params[i].$1,
                decoration: InputDecoration(
                  hintText: 'Parameter Name',
                ),
              ).size(width: 200),
              HGap.small(),
              TextField(
                controller: _params[i].$2,
                decoration: InputDecoration(
                  hintText: 'Parameter Description',
                ),
              ).expand(),
              HGap.small(),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'String',
                ),
              ).size(width: 100),
              HGap.small(),
              SecondaryButton(
                icon: Icons.close,
                description: 'description',
                onPressed: () {
                  setState(() {
                    _params.remove(_params[i]);
                  });
                },
              )
            ].row(),
          VGap.small(),
          ColoredBox(
            color: context.colorScheme.surface,
            child: TextField(
              controller: _valueController,
              maxLines: 32,
              minLines: 16,
            ).padByUnits(1, 1, 1, 1),
          ),
        ],
      ).min(height: 400, width: 880),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        Consumer(
          builder: (context, ref, child) => TextButton(
            child: 'OK'.txt,
            onPressed: () {
              if (_nameController.text.isEmpty) return;
              if (_descriptionController.text.isEmpty) return;
              if (_titleController.text.isEmpty) return;
              if (_valueController.text.isEmpty) return;

              if (widget.tool != null) {
                ref.read(toolsNotifierProvider.notifier).updateTool(
                      widget.tool!.copyWith(
                        name: _nameController.text,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        value: _valueController.text,
                        parameters: _params
                            .where((e) =>
                                e.$1.text.isNotEmpty && e.$2.text.isNotEmpty)
                            .map(
                              (e) => TestToolParameter(
                                  name: e.$1.text,
                                  description: e.$2.text,
                                  type: 'string'),
                            )
                            .toList(),
                      ),
                    );
                Navigator.of(context).pop();
                return;
              }

              ref.read(toolsNotifierProvider.notifier).newTool(
                    TestTool(
                      id: '${_nameController.text}-${DateTime.now().millisecondsSinceEpoch.toString()}',
                      name: _nameController.text,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      value: _valueController.text,
                      parameters: _params
                          .map(
                            (e) => TestToolParameter(
                                name: e.$1.text,
                                description: e.$2.text,
                                type: 'string'),
                          )
                          .toList(),
                    ),
                  );
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _valueController.dispose();
    _titleController.dispose();
    for (var i = 0; i < _params.length; i++) {
      _params[i].$1.dispose();
      _params[i].$2.dispose();
    }
    super.dispose();
  }
}
