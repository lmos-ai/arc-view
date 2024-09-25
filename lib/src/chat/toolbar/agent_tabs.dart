// /*
//  * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
//  *
//  * SPDX-License-Identifier: Apache-2.0
//  */
//
// import 'package:arc_view/src/client/agents_notifier.dart';
// import 'package:arc_view/src/core/extensions.dart';
// import 'package:arc_view/src/core/secondary_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class AgentTabs extends ConsumerWidget {
//   const AgentTabs({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final agents = ref.watch(agentsNotifierProvider).valueOrNull;
//
//     return Row(
//       children: [
//         SecondaryButton(
//           icon: Icons.refresh,
//           onPressed: () => ref.refreshAgents(),
//         ),
//         if (agents == null || agents.names.isEmpty)
//           'No Agents found'
//               .style(color: context.colorScheme.onSurface.withOpacity(0.5))
//               .pad(4, 8, 4, 8),
//         if (agents != null)
//           for (var e in agents.names)
//             ((e == agents.activated)
//                 ? Container(
//                     decoration: BoxDecoration(
//                       color:
//                           context.colorScheme.primaryContainer.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: e.txt.pad(4, 8, 4, 8))
//                 : e.onPressed(() {
//                     ref.activateAgent(e, agents.names);
//                   }))
//       ],
//     );
//   }
// }
