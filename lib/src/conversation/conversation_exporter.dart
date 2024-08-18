/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';
import 'dart:typed_data';

import 'package:arc_view/src/conversation/conversation.dart';
import 'package:arc_view/src/conversation/conversation_message.dart';
import 'package:arc_view/src/conversation/conversation_notifier.dart';
import 'package:file_selector/file_selector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_exporter.g.dart';

@riverpod
ConversationExporter conversationExporter(ConversationExporterRef ref) {
  return ConversationExporter(ref.watch(conversationNotifierProvider));
}

class ConversationExporter {
  ConversationExporter(this.conversation);

  final Conversation conversation;

  export() async {
    const String fileName = 'conversation.json';
    final result = await getSaveLocation(suggestedName: fileName);
    if (result == null) return;

    final exportConversation = conversation.copyWith(
      messages: conversation.messages
          .where((element) => element.type != MessageType.loading)
          .toList(),
    );
    final Uint8List fileData =
        Uint8List.fromList(jsonEncode(exportConversation.toJson()).codeUnits);
    final XFile textFile = XFile.fromData(
      fileData,
      mimeType: 'application/json',
      name: fileName,
    );
    await textFile.saveTo(result.path);
  }
}
