import 'package:arc_view/src/client/agent_url.dart';
import 'package:arc_view/src/client/graphql/agent_query.dart';
import 'package:arc_view/src/client/graphql/agent_subscription.dart';
import 'package:arc_view/src/conversation/chat_message.dart';
import 'package:graphql/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'oneai_client.g.dart';

@riverpod
OneAIClient oneAIClient(OneAIClientRef ref) {
  final agentUrl = ref.watch(agentUrlProvider);
  final httpLink = HttpLink('${agentUrl.$1}/graphql');

  final websocketLink = WebSocketLink(
    '${agentUrl.secure ? 'wss://' : 'ws://'}${agentUrl.$1.host}:${agentUrl.$1.port}/subscriptions',
    subProtocol: GraphQLProtocol.graphqlTransportWs,
  );
  Link link =
      Link.split((request) => request.isSubscription, websocketLink, httpLink);
  final GraphQLClient client = GraphQLClient(cache: GraphQLCache(), link: link);
  print(websocketLink.url);
  return OneAIClient(client);
}

class OneAIClient {
  OneAIClient(this._client);

  final GraphQLClient _client;

  Stream<String> sendMessage(List<ChatMessage> messages) {
    if (messages.isEmpty) return const Stream.empty();
    final subscription = _client.subscribe(
      SubscriptionOptions(
        document: agentSubscription(),
        variables: {
          'conversationId': messages.first.conversationId,
          'messages': messages
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
      if (e.hasException) return e.exception.toString();
      return e.data!['agent']['messages'][0]['content'];
    });
  }

  Future<bool> isConnected() async {
    final result = await _client.query(QueryOptions(document: agentQuery()));
    return !result.hasException;
  }
}
