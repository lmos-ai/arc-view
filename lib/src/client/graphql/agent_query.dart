/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:graphql/client.dart';

agentQuery() {
  return gql('''
  query	{
     agent(id: "s") {
      names
     }
   }
  ''');
}
