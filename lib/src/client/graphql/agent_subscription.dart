import 'package:graphql/client.dart';

agentSubscription(String conversationId, String message) {
  return gql('''
   subscription {
    agent(request: {
      conversationContext: {
        conversationId: "$conversationId",
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
      messages: [
        {
          content: "$message",
          role: "user",
          format: "text"
        }
      ]
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
