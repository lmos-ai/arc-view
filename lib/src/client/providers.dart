import 'package:arc_view/src/client/oneai_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
String conversationId(ConversationIdRef ref) {
  return 'conversationId-${DateTime.now().millisecondsSinceEpoch}';
}

@riverpod
Future<String> agents(AgentsRef ref) async {
  return await ref.watch(oneAIClientProvider).isConnected()
      ? 'connected'
      : 'disconnected';
}
