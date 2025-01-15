/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:graphql/client.dart';

agentSubscription() {
  return gql(r'''
   subscription agent($agent: String, $conversationId: String!, $messages: [MessageInput!]!, $userContext: UserContextInput!, $systemContext: [SystemContextEntryInput!]!) {
    agent(agentName: $agent, request: {
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
      }
      responseTime
      messages {
        content
      }
    }
}
  ''');
}
