/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/graphql/agent_query.dart';
import 'package:arc_view/src/client/graphql/agent_subscription.dart';
import 'package:arc_view/src/client/graphql/event_subscription.dart';
import 'package:arc_view/src/client/notifiers/agent_client_notifier.dart';
import 'package:arc_view/src/conversation/models/conversation.dart';
import 'package:arc_view/src/conversation/models/conversation_message.dart';
import 'package:arc_view/src/events/models/agent_events.dart';
import 'package:graphql/client.dart';
import 'package:logging/logging.dart';

class OneAIClient {
  OneAIClient(this.agentUrl) : _client = _buildGraphQLClient(agentUrl);

  final AgentUrlData agentUrl;
  final GraphQLClient _client;
  final _log = Logger('OneAIClient');

  Future<List<String>> getAgents() async {
    final result = await _client.query(QueryOptions(
      document: agentQuery(),
      fetchPolicy: FetchPolicy.noCache,
    ));
    _log.fine('Agents: $result');
    if (result.hasException) return List.empty();
    return (result.data!['agent']['names'] as List)
        .map((e) => e.toString())
        .toList();
  }

  Stream<MessageResult> sendMessage(Conversation conversation) {
    if (conversation.messages.isEmpty) return const Stream.empty();

    final subscription = _client.subscribe(
      SubscriptionOptions(
        document: agentSubscription(),
        variables: {
          if (agentUrl.agent != null) 'agent': agentUrl.agent,
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
      final agent = agentUrl.agent ?? 'default';
      if (e.hasException) {
        return (
          message: e.exception.toString(),
          responseTime: -1.0,
          agent: agent
        );
      }
      final data = e.data!['agent'];
      _log.fine('Received message: $data');
      return (
        message: data['messages'][0]['content'],
        responseTime: data['responseTime'],
        agent: agent
      );
    });
  }

  Stream<AgentEvent?> listenToEvents() {
    _log.fine('Subscribing to events...');
    final subscription = _client.subscribe(
      SubscriptionOptions(
        document: eventSubscription(),
      ),
    );
    return subscription.map((e) {
      if (e.hasException) return null;
      final data = e.data!['events'];
      _log.fine('Received message: $data');
      return AgentEvent.fromJson(data);
    });
  }

  Future<bool> isConnected() async {
    final result = await _client.query(QueryOptions(document: agentQuery()));
    return !result.hasException;
  }

  close() async {
    await _client.link.dispose();
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

typedef MessageResult = ({String message, double? responseTime, String agent});
