import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_url.g.dart';

@riverpod
class AgentUrl extends _$AgentUrl {
  @override
  String build() => 'localhost:8090';

  setUrl(String url) {
    state = url;
  }
}
