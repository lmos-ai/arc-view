/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:async';

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/usecases/buttons/copy_to_clipboard_button.dart';
import 'package:arc_view/src/usecases/edit_usecase_dialog.dart';
import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:arc_view/src/usecases/search/notifiers/search_notifier.dart';
import 'package:arc_view/src/usecases/search/search_panel.dart';
import 'package:arc_view/src/usecases/search/syntax_text_controller.dart';
import 'package:arc_view/src/usecases/services/usecase_exporter.dart';
import 'package:arc_view/src/usecases/usecase_overview_panel.dart';
import 'package:arc_view/src/usecases/usecase_syntax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';

class UseCasePanel extends StatefulWidget {
  const UseCasePanel({super.key});

  @override
  State<UseCasePanel> createState() => _UseCasePanelState();
}

class _UseCasePanelState extends State<UseCasePanel> {
  bool _showSource = false;
  final _textController = SyntaxTextController();
  final _scrollController = ScrollController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final UseCase? selectedCase =
          ref.watch(useCasesNotifierProvider).valueOrNull?.selectedCase;

      if (_textController.text != selectedCase?.content) {
        _textController.text = selectedCase?.content ?? '';
      }

      if (selectedCase == null) {
        return 'Add new Use Cases. These are stored locally.'.small.center();
      }

      final searchTerm = ref.watch(searchNotifierProvider)?.nullIfEmpty();
      List<int> findLines = [];

      _textController.clearHighlights();
      if (searchTerm != null) {
        _textController.highlightText(
          searchTerm,
          context.colorScheme.secondary,
        );
        findLines = _findLines(searchTerm);
      }
      _textController.colorText(useCaseSyntax);

      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              if (_showSource && findLines.isNotEmpty) ...[
                SecondaryButton(
                  icon: Icons.clear,
                  description: 'Clear Search',
                  onPressed: () {
                    ref.read(searchNotifierProvider.notifier).clear();
                  },
                ),
                SecondaryButton(
                  icon: Icons.arrow_back_rounded,
                  description: 'First last occurrence',
                  onPressed: () {
                    for (var i = findLines.length - 1; i >= 0; i--) {
                      final targetOffset = (findLines[i] * 20) - 20.0;
                      if (targetOffset < _scrollController.offset) {
                        _scrollController.jumpTo(targetOffset);
                        break;
                      }
                    }
                  },
                ),
                SecondaryButton(
                  icon: Icons.arrow_forward_rounded,
                  description: 'First next occurrence',
                  onPressed: () {
                    for (var i = 0; i < findLines.length; i++) {
                      final targetOffset = (findLines[i] * 20) - 20.0;
                      if (targetOffset > _scrollController.offset + 40) {
                        _scrollController.jumpTo(targetOffset);
                        break;
                      }
                    }
                  },
                )
              ],
              if (_showSource && searchTerm != null)
                'Found: ${findLines.length}'.txt.padByUnits(0, 2, 0, 0),
              if (_showSource) SearchPanel().size(width: 300),
              SecondaryButton(
                icon: Icons.add,
                description: 'Add Use Case',
                onPressed: () {
                  showAddUseCaseDialog(context, ref);
                },
              ),
              SecondaryButton(
                icon: _showSource ? Icons.code : Icons.edit,
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
              CopyToClipboardButton(textProvider: () => _textController.text),
              HGap.small(),
            ],
          ),
          _showSource
              ? Card(
                  margin: const EdgeInsets.all(8),
                  child: TextField(
                    controller: _textController,
                    scrollController: _scrollController,
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
              : UsecaseOverviewPanel()
                  .expand()
                  .animate()
                  .fadeIn(duration: 500.milliseconds),
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

  List<int> _findLines(String searchTerm) {
    final result = <int>[];
    final lines = _textController.text.split('\n');
    for (var i = 0; i < lines.length; i++) {
      final regex = RegExp(searchTerm, caseSensitive: false);
      if (lines[i].contains(regex)) {
        result.add(i);
      }
    }
    return result;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _textController.dispose();
    super.dispose();
  }
}
