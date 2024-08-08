import 'package:arc_view/src/chat/models/chat_message.dart';
import 'package:arc_view/src/client/agent_url.dart';
import 'package:arc_view/src/client/graphql/agent_query.dart';
import 'package:arc_view/src/client/graphql/agent_subscription.dart';
import 'package:graphql/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'oneai_client.g.dart';

@riverpod
OneAIClient oneAIClient(OneAIClientRef ref) {
  final agentUrl = ref.watch(agentUrlProvider);
  final httpLink = HttpLink('http://$agentUrl/graphql');
  final websocketLink = WebSocketLink(
    'ws://$agentUrl/subscriptions',
    subProtocol: GraphQLProtocol.graphqlTransportWs,
  );
  Link link =
      Link.split((request) => request.isSubscription, websocketLink, httpLink);
  final GraphQLClient client = GraphQLClient(cache: GraphQLCache(), link: link);

  return OneAIClient(client);
}

class OneAIClient {
  OneAIClient(this.client);

  final GraphQLClient client;

  Stream<String> sendMessage(ChatMessage message) {
    final subscription = client.subscribe(SubscriptionOptions(
        document: agentSubscription(message.conversationId, message.content)));
    return subscription.map((e) => e.data!['agent']['messages'][0]['content']);
  }

  Future<bool> isConnected() async {
    final result = await client.query(QueryOptions(document: agentQuery()));
    return !result.hasException;
  }
}
