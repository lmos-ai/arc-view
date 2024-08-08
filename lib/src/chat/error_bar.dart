import 'package:arc_view/src/client/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorBar extends ConsumerWidget {
  const ErrorBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connected = ref.watch(agentsProvider).valueOrNull;
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            connected ?? 'disconnected',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
