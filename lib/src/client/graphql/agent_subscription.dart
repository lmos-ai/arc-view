import 'package:graphql/client.dart';

agentSubscription() {
  return gql(r'''
   subscription agent($conversationId: String!, $messages: [MessageInput!]!) {
    agent(request: {
      conversationContext: {
        conversationId: $conversationId,
        anonymizationEntities: []
      },
      systemContext: [
         {
          key: "channelId",
          value: "ONEAPPWEB"
        },
        {
          key: "tenantId",
          value: "de"
        }  
      ]
      userContext: {
        userId: "1234",
        userToken: "token",
        profile: [
          {
            key: "hasMobile",
            value: "true"
          }
        ]
      },
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
