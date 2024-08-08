import 'package:arc_view/src/client/agent_url.dart';
import 'package:arc_view/src/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressBar extends ConsumerWidget {
  const AddressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentUrl = ref.watch(agentUrlProvider);
    return Container(
      padding: const EdgeInsets.all(8),
      height: 64,
      width: double.infinity,
      child: Row(
        children: [
          TextField(
            controller: TextEditingController(text: agentUrl),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Agent Url',
              isDense: true, // Added this
            ),
          ).expand(),
          'GO'.onPressed(() {
            ref.read(agentUrlProvider.notifier).setUrl(agentUrl);
          }),
        ],
      ),
    );
  }
}
