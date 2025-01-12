/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:async';

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:arc_view/src/usecases/search/notifiers/search_notifier.dart';
import 'package:arc_view/src/usecases/search/search_panel.dart';
import 'package:arc_view/src/usecases/search/syntax_text_controller.dart';
import 'package:arc_view/src/usecases/services/usecase_exporter.dart';
import 'package:arc_view/src/usecases/usecase_syntax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UseCasePanel extends StatefulWidget {
  const UseCasePanel({super.key});

  @override
  State<UseCasePanel> createState() => _UseCasePanelState();
}

class _UseCasePanelState extends State<UseCasePanel> {
  bool _showSource = false;
  final _textController = SyntaxTextController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final UseCase? selectedCase =
          ref
              .watch(useCasesNotifierProvider)
              .valueOrNull
              ?.selectedCase;

      if (_textController.text != selectedCase?.content) {
        _textController.text = selectedCase?.content ?? '';
      }

      if (selectedCase == null) {
        return 'Add new Use Cases. These are stored locally.'.small.center();
      }

      final searchTerm = ref.watch(searchNotifierProvider).nullIfEmpty();
      if (searchTerm != null) {
        _textController.highlightText(
            searchTerm, context.colorScheme.secondary);
      } else {
        _textController.clearHighlights();
      }
      _textController.colorText(useCaseSyntax);

      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              selectedCase.name.txt.padByUnits(2, 2, 2, 3),
              Spacer(),
              if (_showSource && searchTerm != null)
                'Found: ${_textController.text.count(searchTerm)}'
                    .txt
                    .padByUnits(0, 2, 0, 0),
              if (_showSource) SearchPanel().size(width: 300),
              SecondaryButton(
                icon: Icons.add,
                description: 'Add Use Case',
                onPressed: () {
                  ref.read(useCasesNotifierProvider.notifier).addUseCase();
                },
              ),
              SecondaryButton(
                icon: Icons.code,
                description: 'Show Source',
                onPressed: () {
                  setState(() {
                    if (_showSource) _saveText(_textController.text, ref, true);
                    _showSource = !_showSource;
                    ref.watch(searchNotifierProvider.notifier).clear();
                  });
                },
              ),
              SecondaryButton(
                icon: Icons.download,
                description: 'Export Use Case',
                onPressed: () {
                  ref.read(useCaseExporterProvider).export(selectedCase);
                },
              ),
              SecondaryButton(
                icon: Icons.copy,
                description: 'Copy to Clipboard',
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(text: _textController.text),
                  ).then((_) {});
                },
              ),
              HGap.small(),
            ],
          ),
          _showSource
              ? Card(
            margin: const EdgeInsets.all(8),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(8),
              ),
              onChanged: (text) {
                _saveText(text, ref);
              },
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
            ),
          ).expand().animate().fadeIn(duration: 200.milliseconds)
              : SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.all(8),
              child: MarkdownBody(
                data: _textController.text,
                onTapLink: (text, href, title) {
                  if (href != null) launchUrlString(href);
                },
              ).padByUnits(3, 3, 3, 3),
            ),
          ).expand().animate().fadeIn(duration: 500.milliseconds),
        ],
      );
    });
  }

  _saveText(String text, WidgetRef ref, [bool force = false]) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if (force) {
      ref.read(useCasesNotifierProvider.notifier).updateSelected(text);
    } else {
      _debounce = Timer(1300.milliseconds, () {
        ref.read(useCasesNotifierProvider.notifier).updateSelected(text);
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _textController.dispose();
    super.dispose();
  }
}
