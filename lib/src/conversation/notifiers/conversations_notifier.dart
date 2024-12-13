/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:arc_view/main.dart';
import 'package:arc_view/src/client/message.dart';
import 'package:arc_view/src/client/message_result.dart';
import 'package:arc_view/src/client/models/system_context.dart';
import 'package:arc_view/src/client/models/user_context.dart';
import 'package:arc_view/src/client/notifiers/agent_client_notifier.dart';
import 'package:arc_view/src/client/notifiers/agent_stream_client_notifier.dart';
import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:arc_view/src/conversation/models/conversations.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversations_notifier.g.dart';

@Riverpod(keepAlive: true)
class ConversationsNotifier extends _$ConversationsNotifier {
  final _log = Logger('ConversationNotifier');

  @override
  Conversations build() {
    final userContext = _loadUserContext();
    final systemContext = _loadSystemContext();
    var newConversation = Conversation(
      createdAt: DateTime.now(),
      userContext: userContext,
      systemContext: systemContext,
      messages: List.empty(),
      conversationId: 'cid-${DateTime.now().millisecondsSinceEpoch}',
    );

    newConversation = addFromQueryParam(newConversation);

    return Conversations(
      conversations: [],
      current: newConversation,
    );
  }

  UserContext _loadUserContext() {
    final json = _load('conversation_user_context');
    final context;
    if (json == null) {
      context = UserContext(userId: "unknown", profile: []);
    } else {
      context = UserContext.fromJson(jsonDecode(json));
    }
    return context;
  }

  Conversation addFromQueryParam(Conversation conversation) {
    if (!Uri.base.hasQuery) return conversation;
    var result = conversation;
    var systemContext = conversation.systemContext;
    var userContext = conversation.userContext;
    Uri.base.queryParameters.forEach((key, value) {
      switch (key) {
        case 'user':
          _log.fine('Adding user id: $value');
          userContext = userContext.copyWith(userId: value);
        case 'userToken':
          _log.fine('Adding user token: $value');
          userContext = userContext.copyWith(userToken: value);
        default:
          {
            if (key.startsWith('profile_')) {
              final profileKey = key.substring(8);
              _log.fine('Adding user context: $profileKey -> $value');
              userContext = userContext.copyWith(profile: [
                ...userContext.profile.where((e) => e.key != profileKey),
                ProfileEntry(key: profileKey, value: value)
              ]);
            } else {
              final systemKey = key;
              _log.fine('Adding system context: $systemKey -> $value');
              systemContext = systemContext.copyWith(entries: [
                ...systemContext.entries.where((e) => e.key != systemKey),
                (key: systemKey, value: value)
              ]);
            }
          }
      }
    });
    return result.copyWith(
      userContext: userContext,
      systemContext: systemContext,
    );
  }

  SystemContext _loadSystemContext() {
    final json = _load('conversation_system_context');
    final context;
    if (json == null) {
      context = SystemContext(entries: []);
    } else {
      context = SystemContext.fromJson(jsonDecode(json));
    }
    return context;
  }

  String? _load(String key) =>
      ref.read(sharedPreferencesProvider).getString(key);

  updateConversation(Conversation conversation) {
    final preferences = ref.read(sharedPreferencesProvider);
    preferences.setString('conversation_user_context',
        jsonEncode(conversation.userContext.toJson()));
    preferences.setString('conversation_system_context',
        jsonEncode(conversation.systemContext.toJson()));
    state = state.addAsCurrent(conversation);
  }

  replay() async {
    final conversation = state.current;
    newConversation();
    for (final msg in conversation.messages) {
      if (msg.type == MessageType.loading || msg.type == MessageType.bot) {
        continue;
      }
      await addUserMessage(msg.content);
    }
  }

  Future<void> addUserMessage(String msg) {
    return addMessage(
      ConversationMessage(
        type: MessageType.user,
        content: msg,
        conversationId: state.current.conversationId,
      ),
      null,
    );
  }

  Future<void> addUserVoice(Stream<Uint8List> data) {
    _log.fine('Adding voice message');
    return addMessage(
        ConversationMessage(
          type: MessageType.user,
          content: '',
          conversationId: state.current.conversationId,
          binaryData: [
            BinaryData(data: 'STREAM_SOURCE', mimeType: 'audio/pcm')
          ],
        ),
        data);
  }

  Future<void> addMessage(
    ConversationMessage msg,
    Stream<Uint8List>? data,
  ) async {
    final callback = Completer();

    final conversation = _setLoading(msg);
    state = state.update(conversation);

    final stream = _sendMessage(conversation, data);
    stream.listen((value) {
      if (value.messages.isEmpty) return;
      final newMessages = conversation.messages.filterLoading();
      state = state.update(
        conversation.copyWith(
          messages: [
            ...newMessages.take(newMessages.length - 1), // TODO
            ..._handleBotMessages(value, conversation),
          ],
        ),
      );
      if (!callback.isCompleted) callback.complete();
    });
    return callback.future;
  }

  Stream<MessageResult> _sendMessage(
    Conversation conversation,
    Stream<Uint8List>? data,
  ) {
    if (data != null) {
      return ref
          .read(agentStreamClientNotifierProvider)
          .sendMessage(conversation, data);
    }
    return ref.read(agentClientNotifierProvider).sendMessage(conversation);
  }

  Conversation _setLoading(ConversationMessage msg) {
    final conversation = state.current.add([
      msg,
      loadingMessage(state.current.conversationId),
    ]);
    return conversation;
  }

  List<ConversationMessage> _handleBotMessages(
    MessageResult value,
    Conversation conversation,
  ) {
    return value.messages.map((message) {
      return switch (message) {
        Message(content: '<LOADING>') =>
          loadingMessage(conversation.conversationId),
        Message(role: 'user') => ConversationMessage(
            type: MessageType.user,
            content: message.content,
            conversationId: conversation.conversationId,
            responseTime: value.responseTime,
            agent: value.agent,
          ),
        _ => ConversationMessage(
            type: MessageType.bot,
            content: message.content,
            conversationId: conversation.conversationId,
            responseTime: value.responseTime,
            agent: value.agent,
          )
      };
    }).toList();
  }

  newConversation() {
    state = state.copyWith(current: build().current);
  }

  deleteAll() {
    state = build();
  }

  delete(Conversation conversation) {
    state = state.remove(conversation);
    if (state.current == conversation) {
      newConversation();
    }
  }
}
