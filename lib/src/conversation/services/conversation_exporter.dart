/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';
import 'dart:typed_data';

import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:arc_view/src/conversation/models/conversation_export.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:arc_view/src/conversation/notifiers/conversation_notifier.dart';
import 'package:arc_view/src/events/models/agent_events.dart';
import 'package:arc_view/src/events/notifiers/agent_events_notifier.dart';
import 'package:file_selector/file_selector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_exporter.g.dart';

@riverpod
ConversationExporter conversationExporter(ConversationExporterRef ref) {
  return ConversationExporter(
    ref.watch(conversationNotifierProvider),
    ref.watch(agentEventsNotifierProvider),
  );
}

class ConversationExporter {
  ConversationExporter(this.conversation, this.events);

  final Conversation conversation;
  final List<AgentEvent> events;

  export() async {
    const String fileName = 'conversation.json';
    final result = await getSaveLocation(suggestedName: fileName);
    if (result == null) return;

    final exportConversation = conversation.copyWith(
      messages: conversation.messages
          .where((element) => element.type != MessageType.loading)
          .toList(),
    );
    final export = ConversationExport(
      conversation: exportConversation,
      events: events
          .where((e) => e.conversationId == conversation.conversationId)
          .toList(),
    );
    final Uint8List fileData = utf8.encode(jsonEncode(export.toJson()));
    final XFile textFile = XFile.fromData(
      fileData,
      mimeType: 'application/json',
      name: fileName,
    );
    await textFile.saveTo(result.path);
  }
}
