/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:arc_view/src/conversation/notifiers/conversation_notifier.dart';
import 'package:file_selector/file_selector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_importer.g.dart';

@riverpod
ConversationImporter conversationImporter(ConversationImporterRef ref) {
  return ConversationImporter(ref.watch(conversationNotifierProvider.notifier));
}

class ConversationImporter {
  ConversationImporter(this.conversationNotifier);

  final ConversationNotifier conversationNotifier;

  load() async {
    const XTypeGroup typeGroup = XTypeGroup(extensions: <String>['json']);
    final file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (file == null) return;
    final json = await file.readAsString();
    conversationNotifier
        .updateConversation(Conversation.fromJson(jsonDecode(json)));
  }
}
