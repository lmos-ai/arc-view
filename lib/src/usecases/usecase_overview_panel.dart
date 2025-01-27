/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/usecases/edit_usecase_dialog.dart';
import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
import 'package:arc_view/src/usecases/search/syntax_text_controller.dart';
import 'package:arc_view/src/usecases/usecase_section_list.dart';
import 'package:arc_view/src/usecases/usecase_syntax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiles/smiles.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UsecaseOverviewPanel extends StatefulWidget {
  const UsecaseOverviewPanel({super.key});

  @override
  State<UsecaseOverviewPanel> createState() => _UsecaseOverviewPanelState();
}

class _UsecaseOverviewPanelState extends State<UsecaseOverviewPanel> {
  final _textController = SyntaxTextController()..colorText(useCaseSyntax);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer(builder: (context, ref, _) {
      final UseCase? selectedCase =
          ref.watch(useCasesNotifierProvider).valueOrNull?.selectedCase;
      if (selectedCase == null) return ''.txt;

      final sections = selectedCase.splitContent();
      final sectionKeys = sections.map((s) => GlobalKey()).toList();

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UseCaseSectionList(
            sections: sections,
            onSelect: (i, _) {
              Scrollable.ensureVisible(sectionKeys[i].currentContext!);
            },
          ).size(width: 300),
          SingleChildScrollView(
            child: Column(
              children: [
                for (var i = 0; i < sections.length; i++)
                  Card(
                    key: sectionKeys[i],
                    margin: const EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 40,
                          top: 0,
                          child: SecondaryButton(
                            icon: Icons.delete,
                            description: 'Delete Use Case',
                            onPressed: () {
                              _deleteUseCase(sections, i, ref);
                            },
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: SecondaryButton(
                            icon: Icons.edit,
                            description: 'Edit Use Case',
                            onPressed: () {
                              showEditUseCaseDialog(context, i, sections, ref);
                            },
                          ),
                        ),
                        MarkdownBody(
                          styleSheet:
                              MarkdownStyleSheet.fromTheme(theme).copyWith(
                            horizontalRuleDecoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          data: sections[i].$2,
                          onTapLink: (text, href, title) {
                            if (href != null) launchUrlString(href);
                          },
                        ).padByUnits(2, 2, 2, 2)
                      ],
                    ),
                  )
              ],
            ),
          ).expand()
        ],
      );
    });
  }

  _saveUseCase(String text, List<(String, String)> sections, int sectionIndex,
      WidgetRef ref) {
    var newText = '';
    for (var i = 0; i < sections.length; i++) {
      if (i == sectionIndex) {
        newText += '$text\n';
      } else {
        newText += '${sections[i].$2}\n';
      }
    }
    ref.read(useCasesNotifierProvider.notifier).updateSelected(newText);
  }

  _deleteUseCase(
      List<(String, String)> sections, int sectionIndex, WidgetRef ref) {
    var newText = '';
    for (var i = 0; i < sections.length; i++) {
      if (i != sectionIndex) {
        newText += '${sections[i].$2}\n';
      }
    }
    ref.read(useCasesNotifierProvider.notifier).updateSelected(newText);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
