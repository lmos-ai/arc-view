/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';
import 'package:smiles/smiles.dart';

///
/// Enables syntax highlighting in a [TextField].
/// See https://www.flutterclutter.dev/flutter/tutorials/styling-parts-of-a-textfield/2021/101326/
///
class SyntaxTextController extends TextEditingController {
  _StyleDefinitions? _styles;
  Pattern? _combinedPattern;

  SyntaxTextController({super.text});

  highlightText(String pattern, Color highlight) {
    final styleDefinitions = [
      _StyleDefinition(pattern: pattern, highlight: highlight)
    ];
    _styles = _styles == null
        ? _StyleDefinitions(styleDefinitions)
        : _styles!.add(styleDefinitions);
    _combinedPattern = _styles!.toPattern();
  }

  colorText(Map<String, Color> stylings) {
    final styleDefinitions = stylings.entries
        .map((e) => _StyleDefinition(
              pattern: e.key,
              color: e.value,
              caseSensitive: true,
            ))
        .toList();
    _styles = _styles == null
        ? _StyleDefinitions(styleDefinitions)
        : _styles!.add(styleDefinitions);
    _combinedPattern = _styles!.toPattern();
  }

  clearHighlights() {
    _styles = null;
    _combinedPattern = null;
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    if (_combinedPattern == null) {
      return super.buildTextSpan(
        context: context,
        style: style,
        withComposing: withComposing,
      );
    }

    final List<InlineSpan> textSpanChildren = <InlineSpan>[];
    text.splitMapJoin(
      _combinedPattern!,
      onMatch: (Match match) {
        final String? textPart = match.group(0);
        if (textPart == null) return '';
        final styleDefinition = _styles!.getStyleFor(textPart);

        if (styleDefinition == null) {
          textSpanChildren.add(TextSpan(text: textPart, style: style));
        } else {
          textSpanChildren.add(TextSpan(
              text: textPart, style: style?.merge(styleDefinition.style)));
        }
        return '';
      },
      onNonMatch: (String text) {
        textSpanChildren.add(TextSpan(text: text, style: style));
        return '';
      },
    );

    return TextSpan(style: style, children: textSpanChildren);
  }
}

class _StyleDefinitions {
  _StyleDefinitions(this.definitionList);

  final List<_StyleDefinition> definitionList;

  RegExp toPattern() {
    final String combinedPatternString =
        definitionList.map((definition) => definition.pattern).join('|');
    return RegExp(combinedPatternString, multiLine: true, caseSensitive: false);
  }

  _StyleDefinition? getStyleFor(String text) {
    return definitionList.findFirst((styleDefinition) {
      return RegExp(
        styleDefinition.pattern,
        caseSensitive: styleDefinition.caseSensitive,
      ).hasMatch(text);
    });
  }

  add(List<_StyleDefinition> toAdd) {
    return _StyleDefinitions(definitionList + toAdd);
  }
}

class _StyleDefinition {
  _StyleDefinition(
      {required this.pattern,
      Color? highlight,
      Color? color,
      this.caseSensitive = false})
      : style = TextStyle(
          color: color ?? Colors.white,
          fontWeight: FontWeight.bold,
          backgroundColor: highlight,
        );

  final bool caseSensitive;
  final String pattern;
  final TextStyle style;
}
