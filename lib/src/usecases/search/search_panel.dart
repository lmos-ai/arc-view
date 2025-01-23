/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/search/notifiers/search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// Search Panel
///
class SearchPanel extends ConsumerStatefulWidget {
  const SearchPanel({super.key});

  @override
  SearchPanelState createState() => SearchPanelState();
}

class SearchPanelState extends ConsumerState<SearchPanel> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cleared = ref.watch(searchNotifierProvider.select((e) => e == null));

    if (cleared) {
      _textController.clear();
    }

    return SearchBar(
      controller: _textController,
      textStyle: WidgetStatePropertyAll<TextStyle>(theme.textTheme.bodyMedium!),
      constraints: BoxConstraints(maxHeight: 80),
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(4)),
      onSubmitted: (text) {
        ref.read(searchNotifierProvider.notifier).search(text);
      },
      onTap: () {
        ref.read(searchNotifierProvider.notifier).search(_textController.text);
      },
      leading: const Icon(Icons.search),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
