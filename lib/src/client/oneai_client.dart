/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/agent_client_notifier.dart';
import 'package:arc_view/src/client/graphql/agent_query.dart';
import 'package:arc_view/src/client/graphql/agent_subscription.dart';
import 'package:arc_view/src/conversation/conversation.dart';
import 'package:arc_view/src/conversation/conversation_message.dart';
import 'package:graphql/client.dart';
import 'package:logging/logging.dart';

class OneAIClient {
  OneAIClient(this.agentUrl) : _client = _buildGraphQLClient(agentUrl);

  final AgentUrlData agentUrl;
  final GraphQLClient _client;
  final _log = Logger('OneAIClient');

  Future<List<String>> getAgents() async {
    final result = await _client.query(QueryOptions(document: agentQuery()));
    if (result.hasException) return List.empty();
    return (result.data!['agent']['names'] as List)
        .map((e) => e.toString())
        .toList();
  }

  Stream<(String, double?)> sendMessage(Conversation conversation) {
    if (conversation.messages.isEmpty) return const Stream.empty();

    final subscription = _client.subscribe(
      SubscriptionOptions(
        document: agentSubscription(),
        variables: {
          'conversationId': conversation.conversationId,
          'userContext': conversation.userContext.toJson(),
          'systemContext': conversation.systemContext.entries
              .map((e) => {
                    'key': e.key,
                    'value': e.value,
                  })
              .toList(),
          'messages': conversation.messages
              .where((e) => e.type != MessageType.loading)
              .map((e) => {
                    'content': e.content,
                    'role': e.type == MessageType.user ? 'user' : 'assistant',
                    'format': 'text',
                  })
              .toList(),
        },
      ),
    );
    return subscription.map((e) {
      if (e.hasException) return (e.exception.toString(), -1.0);
      final data = e.data!['agent'];
      _log.fine('Received message: $data');
      return (data['messages'][0]['content'], data['responseTime']);
    });
  }

  Future<bool> isConnected() async {
    final result = await _client.query(QueryOptions(document: agentQuery()));
    return !result.hasException;
  }

  static GraphQLClient _buildGraphQLClient(AgentUrlData agentUrl) {
    final httpLink = HttpLink('${agentUrl.url}/graphql');

    final websocketLink = WebSocketLink(
      '${agentUrl.secure ? 'wss://' : 'ws://'}${agentUrl.url.host}:${agentUrl.url.port}/subscriptions',
      subProtocol: GraphQLProtocol.graphqlTransportWs,
    );
    Link link = Link.split(
        (request) => request.isSubscription, websocketLink, httpLink);
    return GraphQLClient(cache: GraphQLCache(), link: link);
  }
}
