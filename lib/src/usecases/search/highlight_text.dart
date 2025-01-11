import 'package:flutter/material.dart';

class StyleableTextFieldController extends TextEditingController {
  TextPartStyleDefinitions? _styles;
  Pattern? _combinedPattern;

  highlightText(String pattern, Color highlight) {
    _styles = TextPartStyleDefinitions(
      [TextPartStyleDefinition(pattern: pattern, highlight: highlight)],
    );
    _combinedPattern = _styles!.createCombinedPatternBasedOnStyleMap();
  }

  colorText(Map<String, Color> stylings) {
    final styleDefinitions = stylings.entries
        .map((e) => TextPartStyleDefinition(pattern: e.key, color: e.value))
        .toList();
    _styles = _styles == null
        ? TextPartStyleDefinitions(styleDefinitions)
        : _styles!.add(styleDefinitions);
    _combinedPattern = _styles!.createCombinedPatternBasedOnStyleMap();
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

        final TextPartStyleDefinition? styleDefinition =
            _styles!.getStyleOfTextPart(textPart, text);

        if (styleDefinition == null) return '';

        _addTextSpan(
          textSpanChildren,
          textPart,
          style?.merge(styleDefinition.style),
        );

        return '';
      },
      onNonMatch: (String text) {
        _addTextSpan(textSpanChildren, text, style);
        return '';
      },
    );
    return TextSpan(style: style, children: textSpanChildren);
  }

  void _addTextSpan(
    List<InlineSpan> textSpanChildren,
    String? textToBeStyled,
    TextStyle? style,
  ) {
    textSpanChildren.add(
      TextSpan(
        text: textToBeStyled,
        style: style,
      ),
    );
  }
}

class TextPartStyleDefinitions {
  TextPartStyleDefinitions(this.definitionList);

  final List<TextPartStyleDefinition> definitionList;

  RegExp createCombinedPatternBasedOnStyleMap() {
    final String combinedPatternString = definitionList
        .map<String>(
          (textPartStyleDefinition) => textPartStyleDefinition.pattern,
        )
        .join('|');

    return RegExp(
      combinedPatternString,
      multiLine: true,
      caseSensitive: false,
    );
  }

  TextPartStyleDefinition? getStyleOfTextPart(
    String textPart,
    String text,
  ) {
    return List<TextPartStyleDefinition?>.from(definitionList).firstWhere(
      (TextPartStyleDefinition? styleDefinition) {
        if (styleDefinition == null) return false;

        bool hasMatch = false;

        RegExp(styleDefinition.pattern, caseSensitive: false)
            .allMatches(text)
            .forEach(
          (RegExpMatch currentMatch) {
            if (hasMatch) return;

            if (currentMatch.group(0) == textPart) {
              hasMatch = true;
            }
          },
        );
        return hasMatch;
      },
      orElse: () => null,
    );
  }

  add(List<TextPartStyleDefinition> toAdd) {
    return TextPartStyleDefinitions(definitionList + toAdd);
  }
}

class TextPartStyleDefinition {
  TextPartStyleDefinition(
      {required this.pattern, Color? highlight, Color? color})
      : style = TextStyle(
          color: color ?? Colors.white,
          fontWeight: FontWeight.bold,
          backgroundColor: highlight,
        );

  final String pattern;
  final TextStyle style;
}
