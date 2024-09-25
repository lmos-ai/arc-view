/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/agent_client_notifier.dart';
import 'package:arc_view/src/client/graphql/agent_query.dart';
import 'package:arc_view/src/client/graphql/agent_subscription.dart';
import 'package:arc_view/src/client/system_context.dart';
import 'package:arc_view/src/client/user_context.dart';
import 'package:arc_view/src/conversation/conversation.dart';
import 'package:arc_view/src/conversation/conversation_message.dart';
import 'package:arc_view/src/conversation/conversation_notifier.dart';
import 'package:graphql/client.dart';
import 'package:logging/logging.dart';
import 'dart:convert';
import 'package:arc_view/src/client/agent_client_notifier.dart';
import 'package:arc_view/src/conversation/conversation.dart';
import 'package:arc_view/src/conversation/conversation_message.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class OneAIClient {
  OneAIClient(this.agentUrl, this.conversationNotifier) : _log = Logger('OneAIClient');

  final AgentUrlData agentUrl;
  final ConversationNotifier conversationNotifier;

  var _log = Logger('OneAIClient');

  Future<List<String>> getAgents() async {
    final url = Uri.parse('${agentUrl.url}/actuator/health');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return ['Runtime'];
    } else {
      return ['Health check failed for lmos-runtime at url: $url'];
    }
  }

  Future<ConversationMessage> sendMessage(Conversation conversation) async {
    var defaultResponse = Future.value(ConversationMessage(type: MessageType.bot, conversationId: conversation.conversationId, content: '',));
    if (conversation.messages.isEmpty) return defaultResponse;

    final filteredMessages = conversation.messages
        .where((message) => message.type != MessageType.loading)
        .toList();

    final List<Map<String, String>> formattedMessages = filteredMessages.map((message) {
      return {
        'role': message.type == MessageType.user ? 'user' : 'assistant',
        'format': 'text',
        'content': message.content,
      };
    }).toList();

    var systemContext = getSystemContext();
    var userContext = getUserContext();

    var tenantId = systemContext.entries.firstWhere((entry) => entry.key == 'tenantId').value;
    var channelId = systemContext.entries.firstWhere((entry) => entry.key == 'channelId').value;
    final url = Uri.parse('${agentUrl.url}/lmos/runtime/apis/v1/$tenantId/chat/${conversation.conversationId}/message');

    final headers = {
      'Content-Type': 'application/json',
      'x-turn-id': '1',
    };

    final body = jsonEncode({
      'inputContext': {
        'messages': formattedMessages,
      },
      'systemContext': {
        'channelId': channelId,
      },
      'userContext': {
        'userId': userContext.userId,
      },
    });

    print(body);

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Extract message from response and handle accordingly
        // Assume response data contains 'content' and 'responseTime' fields for simplicity
        final messageContent = data['content'];
        final responseTime = 0.0;
        // data['outputContext']['messages'][0]['responseTime'];

        // Update conversation state here
        // Typically, this code would be moved to a notifier or state manager
        final newMessage = ConversationMessage(
          type: MessageType.bot,
          content: messageContent,
          conversationId: conversation.conversationId,
          responseTime: responseTime,
        );
        return newMessage;
        // Update the conversation state accordingly
      } else {
        _log.warning('Failed to send message: ${response.statusCode} ${response.reasonPhrase}');
        defaultResponse = Future.value(ConversationMessage(type: MessageType.bot, conversationId: conversation.conversationId, content: response.body));
      }
    } catch (e) {
      _log.severe('Error during sending the message: $e');
      defaultResponse = Future.value(ConversationMessage(type: MessageType.bot, conversationId: conversation.conversationId, content: e.toString()));
    }
    return defaultResponse;
  }

  SystemContext getSystemContext() {
    return conversationNotifier.loadSystemContext();
  }

  UserContext getUserContext() {
    return conversationNotifier.loadUserContext();
  }
}

//   Future<bool> isConnected() async {
//     final result = await _client.query(QueryOptions(document: agentQuery()));
//     return !result.hasException;
//   }
//
//   static GraphQLClient _buildGraphQLClient(AgentUrlData agentUrl) {
//     final httpLink = HttpLink('${agentUrl.url}/graphql');
//
//     final websocketLink = WebSocketLink(
//       '${agentUrl.secure ? 'wss://' : 'ws://'}${agentUrl.url.host}:${agentUrl.url.port}/subscriptions',
//       subProtocol: GraphQLProtocol.graphqlTransportWs,
//     );
//     Link link = Link.split(
//         (request) => request.isSubscription, websocketLink, httpLink);
//     return GraphQLClient(cache: GraphQLCache(), link: link);
//   }
// }
