/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/home/home_panel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smiles/smiles.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: 'Home'.txt),
        body: [
          GradientText(
            'Welcome to the Arc View!',
            style: TextStyle(
              fontSize: 40.0,
            ),
            colors: [
              Colors.purple,
              context.colorScheme.primary,
            ],
          ).center(),
          'What magic should we create today?'.txt.padByUnits(2, 2, 2, 2),
          VGap.small(),
          Wrap(children: [
            HomePanel(
              headline: 'Use Case Based Agents',
              body: [
                'Create new Agents by simply defining their use cases in a simple structured format.'
                    .txt,
                [
                  'Click here for more information:'.txt,
                  'here'.onPressed(() {
                    launchUrlString(
                        'https://eclipse.dev/lmos/docs/arc/use_cases');
                  })
                ].row(min: true),
              ],
              button: 'Open UseCases'
                  .onButtonPressed(() => context.go('/usecases')),
            ),
            HGap(),
            HomePanel(
              headline: 'Agent Chat',
              body: [
                'Chat with your Agents and test their behavior.'.txt,
              ],
              button: 'Open Chat'.onButtonPressed(() => context.go('/chat')),
            ),
            HomePanel(
              headline: 'Agent Metrics',
              body: [
                'Get a feel for how well your Agent is performing and how much it is consuming.'
                    .txt,
              ],
              button:
                  'Open Charts'.onButtonPressed(() => context.go('/charts')),
            ),
          ]).expand(),
          VGap(),
        ].column());
  }
}
