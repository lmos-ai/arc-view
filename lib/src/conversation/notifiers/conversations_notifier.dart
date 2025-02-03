/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:async';
import 'dart:convert';

import 'package:arc_view/main.dart';
import 'package:arc_view/src/client/models/message.dart';
import 'package:arc_view/src/client/models/message_result.dart';
import 'package:arc_view/src/client/models/system_context.dart';
import 'package:arc_view/src/client/models/user_context.dart';
import 'package:arc_view/src/client/notifiers/agent_client_notifier.dart';
import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:arc_view/src/conversation/models/conversations.dart';
import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversations_notifier.g.dart';

@Riverpod(keepAlive: true)
class ConversationsNotifier extends _$ConversationsNotifier {
  final _log = Logger('ConversationNotifier');

  @override
  Conversations build() => _build();

  Conversations _build({String? conversationId}) {
    final userContext = _loadUserContext();
    final systemContext = _loadSystemContext();
    var newConversation = Conversation(
      createdAt: DateTime.now(),
      userContext: userContext,
      systemContext: systemContext,
      messages: List.empty(),
      conversationId:
          conversationId ?? 'cid-${DateTime.now().millisecondsSinceEpoch}',
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
    final SystemContext context;
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

  replay({
    UseCase? useCase,
    Conversation? replay,
    String? conversationId,
  }) async {
    final conversation = replay ?? state.current;
    newConversation(conversationId: conversationId);
    for (final msg in conversation.messages) {
      if (msg.type == MessageType.bot) continue;
      await sendUserMessage(msg.content, useCase: useCase);
    }
  }

  updateAndReplay(
    ConversationMessage oldMessage,
    ConversationMessage newMessage, {
    UseCase? useCase,
  }) async {
    final conversation = state.conversations.firstWhere(
      (element) => element.conversationId == oldMessage.conversationId,
    );
    final updatedConversation = conversation.copyWith(
        messages: conversation.messages.map((msg) {
      if (msg == oldMessage) return newMessage;
      return msg;
    }).toList());

    updateConversation(updatedConversation);
    await replay(replay: updatedConversation, useCase: useCase);
  }

  Future<void> sendUserMessage(String msg, {UseCase? useCase}) {
    final callback = Completer();
    final updatedConversation = addUserRequest(msg, state.current);

    _log.fine('Sending message: $updatedConversation');
    ref
        .read(agentClientNotifierProvider)
        .sendMessage(updatedConversation.addUseCase(useCase))
        .listen((value) {
      addBotResponse(value, updatedConversation);
      if (!callback.isCompleted) callback.complete();
    });
    return callback.future;
  }

  ///
  /// Adds a message from the user to the conversation and sets loading to true.
  ///
  Conversation addUserRequest(String msg, Conversation conversation,
      {bool? streamAudio}) {
    final updatedConversation = conversation.addUserMessage(
      msg,
      loading: true,
      streamAudio: streamAudio,
    );
    state = state.update(updatedConversation);
    return updatedConversation;
  }

  ///
  /// Adds a message from the bot to the conversation and sets loading to false.
  ///
  Conversation addBotResponse(MessageResult value, Conversation conversation) {
    final updatedConversation = conversation.add(
      _handleBotMessages(value, conversation),
      loading: false,
    );
    state = state.update(updatedConversation);
    return updatedConversation;
  }

  List<ConversationMessage> _handleBotMessages(
    MessageResult value,
    Conversation conversation,
  ) {
    if (value.error != null) {
      return [
        ConversationMessage(
          type: MessageType.bot,
          content: 'Error: ${value.error}',
          conversationId: conversation.conversationId,
          responseTime: value.responseTime,
          agent: value.agent,
        )
      ];
    }
    return value.messages.map((message) {
      return switch (message) {
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

  newConversation({String? conversationId}) {
    state = state.copyWith(
      current: _build(conversationId: conversationId).current,
    );
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

extension ConversationsNotifierExtension on Ref {
  Conversation addBotResponse(MessageResult value, Conversation conversation) {
    return read(conversationsNotifierProvider.notifier).addBotResponse(
      value,
      conversation,
    );
  }

  Conversation addUserRequest(String msg, Conversation conversation,
      {bool? streamAudio}) {
    return read(conversationsNotifierProvider.notifier).addUserRequest(
      msg,
      conversation,
      streamAudio: streamAudio,
    );
  }

  Conversation currentConversation() {
    return read(conversationsNotifierProvider).current;
  }
}
