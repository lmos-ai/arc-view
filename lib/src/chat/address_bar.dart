import 'package:arc_view/src/client/agent_url.dart';
import 'package:arc_view/src/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressBar extends StatefulWidget {
  const AddressBar({super.key});

  @override
  State<AddressBar> createState() => _AddressBarState();
}

class _AddressBarState extends State<AddressBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final agentUrl = ref.read(agentUrlProvider);
      return Container(
        padding: const EdgeInsets.all(8),
        height: 64,
        width: double.infinity,
        child: Row(
          children: [
            TextField(
              controller: TextEditingController(text: agentUrl.$1.toString()),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Agent Url',
                isDense: true, // Added this
              ),
              onChanged: (value) {
                ref.read(agentUrlProvider.notifier).setUrl(value);
              },
            ).expand(),
          ],
        ),
      );
    });
  }
}
