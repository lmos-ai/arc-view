/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';

class LargeTitle extends StatelessWidget {
  const LargeTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleLarge);
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}

class SmallText extends StatelessWidget {
  const SmallText(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.bodySmall);
  }
}

class SmallLinkedText extends StatelessWidget {
  const SmallLinkedText(
    this.title, {
    required this.tip,
    this.onPressed,
    super.key,
  });

  final String title;
  final String tip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text('[$title]', style: Theme.of(context).textTheme.bodySmall),
    ).tip(tip);
  }
}
