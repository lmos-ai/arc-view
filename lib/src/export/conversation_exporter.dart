import 'dart:convert';
import 'dart:typed_data';

import 'package:arc_view/src/chat/controllers/chat_controller.dart';
import 'package:arc_view/src/chat/models/conversation.dart';
import 'package:file_selector/file_selector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_exporter.g.dart';

@riverpod
ConversationExporter conversationExporter(ConversationExporterRef ref) {
  return ConversationExporter(ref.watch(chatControllerProvider));
}

class ConversationExporter {
  ConversationExporter(this.conversation);

  final Conversation conversation;

  export() async {
    const String fileName = 'conversation.json';
    final result = await getSaveLocation(suggestedName: fileName);
    if (result == null) return;

    final Uint8List fileData =
        Uint8List.fromList(jsonEncode(conversation.toJson()).codeUnits);
    final XFile textFile = XFile.fromData(
      fileData,
      mimeType: 'application/json',
      name: fileName,
    );
    await textFile.saveTo(result.path);
  }
}
