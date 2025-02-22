/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:arc_view/src/usecases/search/syntax_text_controller.dart';
import 'package:arc_view/src/usecases/usecase_syntax.dart';
import 'package:arc_view/src/usecases/usecase_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class EditUseCaseDialog extends StatefulWidget {
  const EditUseCaseDialog({
    super.key,
    required this.content,
    required this.onSave,
  });

  final String content;
  final Function(String) onSave;

  @override
  State<EditUseCaseDialog> createState() => _EditUseCaseDialogState();
}

class _EditUseCaseDialogState extends State<EditUseCaseDialog> {
  final _textController = SyntaxTextController()..colorText(useCaseSyntax);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) => AlertDialog(
        title: Text('Edit Use Case'),
        content: TextField(
          controller: _textController..text = widget.content,
          minLines: 20,
          maxLines: null,
        ).min(width: 560, height: 0),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onSave(_textController.text);
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

///
/// Shows the [EditUseCaseDialog].
///
///
showAddUseCaseDialog(String useCaseId, BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) {
      return EditUseCaseDialog(
          content: addUseCaseTemplate,
          onSave: (text) {
            ref
                .read(useCasesNotifierProvider.notifier)
                .addUseCaseChapter(useCaseId, text);
          });
    },
  );
}

showEditUseCaseDialog(
  BuildContext context,
  int selected,
  List<(String, String)> useCases,
  WidgetRef ref,
  String useCaseId,
) {
  showDialog(
    context: context,
    builder: (context) {
      return EditUseCaseDialog(
          content: useCases[selected].$2,
          onSave: (text) {
            _saveUseCase(text, useCases, selected, ref, useCaseId);
          });
    },
  );
}

_saveUseCase(
  String text,
  List<(String, String)> useCases,
  int sectionIndex,
  WidgetRef ref,
  String useCaseId,
) {
  var newText = '';
  for (var i = 0; i < useCases.length; i++) {
    if (i == sectionIndex) {
      newText += '$text\n';
    } else {
      newText += '${useCases[i].$2}\n';
    }
  }
  ref
      .read(useCasesNotifierProvider.notifier)
      .updateUseCaseById(useCaseId, newText);
}
