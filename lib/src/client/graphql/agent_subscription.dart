import 'package:graphql/client.dart';

agentSubscription() {
  return gql(r'''
   subscription agent($conversationId: String!, $messages: [MessageInput!]!, $userContext: UserContextInput!, $systemContext: [SystemContextEntryInput!]!) {
    agent(request: {
      conversationContext: {
        conversationId: $conversationId,
        anonymizationEntities: []
      },
      systemContext: $systemContext,
      userContext: $userContext,
      messages: $messages
    }) {
      anonymizationEntities {
        replacement,
        type,
        value
     },
      messages {
        content,
        format,
        role,
        turnId
      }
    }
}
  ''');
}
