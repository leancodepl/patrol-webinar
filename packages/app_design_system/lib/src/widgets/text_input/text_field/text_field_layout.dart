import 'package:boxy/boxy.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

const _minimumInputWidthFactor = 0.2;

@internal
const textFieldSymbol = #input;

@internal
const labeledTextFieldSymbol = #input;

@internal
const clearSymbol = #clear;

@internal
const labelSymbol = #label;

@internal
const placeholderSymbol = #placeholder;

@internal
enum TextFieldDecorationPartType {
  /// Decoration part will take its intrinsic width no matter how much
  /// space there is available.
  intrinsic,

  /// Decoration part will take its intrinsic width if there is enough width
  /// available. In opposite case, to fit the maximum width available, all
  /// parts marked with `proportionable` are reduced proportionally to their
  /// intrinsic widths.
  proportionable,
}

/// Lays out decoration elements inside text field container.
@internal
class TextFieldDecorationLayoutDelegate extends BoxyDelegate {
  TextFieldDecorationLayoutDelegate();

  @override
  Size layout() {
    final input = getChild(labeledTextFieldSymbol);

    final width = this.constraints.maxWidth;

    final height = children.map((child) {
      return child.render.getMinIntrinsicHeight(width);
    }).max;

    final constraints = this.constraints.loosen().copyWith(maxHeight: height);

    var inputMaxWidth = constraints.maxWidth;
    for (final child in children) {
      if (labeledTextFieldSymbol == child.id) {
        continue;
      }

      final childWidth = child.render.getMaxIntrinsicWidth(height);

      inputMaxWidth -= childWidth;
    }

    // Temporary way of dealing with small screen sizes when layouting a text
    // field. We reserve 20% of available width for text field and the rest of
    // Decoration parts is laid out proportionally.
    if (inputMaxWidth < width * 0.2) {
      inputMaxWidth = width * 0.2;

      final proportionableDecorationWidth = children
          .map(
            (child) => switch (child.parentData) {
              TextFieldDecorationPartType.proportionable =>
                child.render.getMinIntrinsicWidth(height),
              _ => 0,
            },
          )
          .sum;

      final nonProportionableDecorationWidth = children
          .map(
            (child) => switch (child.id) {
              labeledTextFieldSymbol => 0,
              _ => switch (child.parentData) {
                TextFieldDecorationPartType.proportionable => 0,
                _ => child.render.getMinIntrinsicWidth(height),
              },
            },
          )
          .sum;

      final proportionableDecorationMaxWidth =
          width - nonProportionableDecorationWidth - inputMaxWidth;

      for (final child in children) {
        if (labeledTextFieldSymbol == child.id) {
          continue;
        }

        if (child.parentData == TextFieldDecorationPartType.proportionable) {
          final childWidth = child.render.getMaxIntrinsicWidth(height);

          child.layout(
            BoxConstraints(
              maxWidth:
                  childWidth *
                  proportionableDecorationMaxWidth /
                  proportionableDecorationWidth,
              maxHeight: height,
            ),
          );
        } else {
          child.layout(BoxConstraints(maxHeight: height));
        }
      }
    } else {
      for (final child in children) {
        if (labeledTextFieldSymbol == child.id) {
          continue;
        }

        child.layout(constraints.loosen().copyWith(maxHeight: height));
      }
    }

    input.layout(
      BoxConstraints(maxWidth: inputMaxWidth, maxHeight: constraints.maxHeight),
    );

    var dx = 0.0;

    for (final child in children) {
      final dy = (height - child.size.height) / 2;
      child.position(Offset(dx, dy));
      dx += child.size.width;
    }

    return Size(width, height);
  }

  @override
  double minIntrinsicHeight(double width) {
    return children.map((child) {
      return child.render.getMinIntrinsicHeight(width);
    }).max;
  }

  @override
  double maxIntrinsicHeight(double width) {
    return minIntrinsicHeight(width);
  }

  @override
  double minIntrinsicWidth(double height) {
    final elementsMinIntrinsicWidth = children.map((child) {
      if (child.id == labeledTextFieldSymbol) {
        return 0.0;
      }
      return child.render.getMinIntrinsicWidth(height);
    }).sum;

    return elementsMinIntrinsicWidth / (1 - _minimumInputWidthFactor);
  }

  @override
  double maxIntrinsicWidth(double height) {
    return minIntrinsicWidth(height);
  }
}
