/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/core/text.dart';
import 'package:flutter/material.dart';

///
/// Widget Extensions
///
extension ContextExtensions on BuildContext {
  bool isMobile() {
    final platform = Theme.of(this).platform;
    return platform == TargetPlatform.iOS || platform == TargetPlatform.android;
  }

  Screen get screen {
    final size = MediaQuery.of(this).size;

    if (size.width < 400) {
      return Screen.small;
    }
    if (size.width < 800) {
      return Screen.medium;
    }
    return Screen.large;
  }

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  T themeExtension<T>() => Theme.of(this).extension<T>()!;
}

enum Screen { small, medium, large }

///
/// String Extensions
///
extension StringExtensions on String {
  Text get txt => Text(this);

  Text style({double? size, Color? color}) =>
      Text(this, style: TextStyle(color: color, fontSize: size));

  Text underline() => Text(this,
      style: const TextStyle(
        decoration: TextDecoration.underline,
      ));

  SubTitle get h2 => SubTitle(this);

  LargeTitle get h1 => LargeTitle(this);

  Widget onPressed(VoidCallback? onPressed) => TextButton(
        onPressed: onPressed,
        child: Text(this),
      );

  Widget onButtonPressed(VoidCallback? onPressed, {bool disabled = false}) =>
      ElevatedButton(
        onPressed: disabled ? null : onPressed,
        child: Text(this),
      );
}

///
/// Widget Extensions
///
extension WidgetExtensions on Widget {
  Widget padding([double padding = 8.0]) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget pad(double top, double right, double bottom, double left) => Padding(
        padding:
            EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
        child: this,
      );

  Widget paddingLeft([double padding = 8.0]) => Padding(
        padding: EdgeInsets.only(left: padding),
        child: this,
      );

  Widget paddingBottom([double padding = 8.0]) => Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: this,
      );

  Widget paddingRight([double padding = 8.0]) => Padding(
        padding: EdgeInsets.only(right: padding),
        child: this,
      );

  Widget toRight() => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: this,
      );

  Widget toLeft() => Align(
        alignment: AlignmentDirectional.centerStart,
        child: this,
      );

  Widget size(
          {double? maxWidth,
          double? maxHeight,
          double? minWidth,
          double? minHeight}) =>
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? double.infinity,
          maxHeight: maxHeight ?? double.infinity,
          minWidth: minWidth ?? 0.0,
          minHeight: minHeight ?? 0.0,
        ),
        child: this,
      );

  Widget max({double? width, double? height}) => ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width ?? double.infinity,
          maxHeight: height ?? double.infinity,
        ),
        child: this,
      );

  Widget min({double? width, double? height}) => ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: width ?? double.infinity,
          minHeight: height ?? double.infinity,
        ),
        child: this,
      );

  Widget expand({double? maxWidth, double? maxHeight}) => Expanded(child: this);
}

extension IconExtensions on IconData {
  Widget onPressed({VoidCallback? onPressed, double? size, Color? color}) =>
      IconButton(
          onPressed: onPressed,
          icon: Icon(
            this,
            size: size,
            color: color,
          ));
}
