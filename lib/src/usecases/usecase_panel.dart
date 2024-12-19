/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:arc_view/src/usecases/notifiers/usecases_notifier.dart';
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

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final selectedCase =
          ref.watch(useCasesNotifierProvider).valueOrNull?.selectedCase;
      _textController.text = selectedCase.content ?? '';

      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (selectedCase != null) selectedCase?.name?.txt.pad(8, 8, 8, 8),
              Spacer(),
              SecondaryButton(
                icon: Icons.code,
                description: 'Show Source',
                onPressed: () {
                  setState(() {
                    _showSource = !_showSource;
                  });
                },
              ),
              SecondaryButton(
                icon: Icons.save,
                description: 'Save',
                onPressed: () {},
              ),
              SecondaryButton(
                icon: Icons.copy,
                description: 'Copy to Clipboard',
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(text: _textController.text),
                  ).then(
                    (_) {
                      // TODO
                    },
                  );
                },
              ),
              HGap.small(),
            ],
          ),
          _showSource
              ? TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                ).expand().animate().fadeIn(duration: 200.milliseconds)
              : SingleChildScrollView(
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: MarkdownBody(
                      fitContent: false,
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

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
