/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';

class HoverableListTile extends StatefulWidget {
  const HoverableListTile({
    super.key,
    required this.buttons,
    this.title,
    this.onTap,
  });

  final List<SecondaryButton> buttons;

  final Widget? title;
  final GestureTapCallback? onTap;

  @override
  State<HoverableListTile> createState() => _HoverableListTileState();
}

class _HoverableListTileState extends State<HoverableListTile> {
  bool _onOver = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) {
        if (!mounted) return;
        setState(() {
          _onOver = true;
        });
      },
      onExit: (e) {
        if (!mounted) return;
        setState(() {
          _onOver = false;
        });
      },
      child: ListTile(
        dense: true,
        title: widget.title,
        onTap: widget.onTap,
        trailing: Builder(
          builder: (context) {
            final hasFocus = Focus.of(context).hasFocus;
            return hasFocus || _onOver
                ? widget.buttons.row(min: true)
                : SizedBox();
          },
        ),
      ),
    );
  }
}
