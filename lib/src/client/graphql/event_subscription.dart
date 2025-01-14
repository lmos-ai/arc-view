/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:graphql/client.dart';

eventSubscription() {
  return gql(r'''
   subscription events {
    events {
      type
      payload
      conversationId
    }
}
  ''');
}
