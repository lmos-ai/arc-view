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
