/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
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
    }
}
  ''');
}
