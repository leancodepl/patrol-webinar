import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
enum InputLabelPosition {
  internal,
  external;

  bool get isInternal => this == InputLabelPosition.internal;

  bool get isExternal => this == InputLabelPosition.external;

  static InputLabelPosition resolve(
    FocusNode focusNode,
    TextEditingController controller,
  ) {
    if (!focusNode.hasFocus && controller.text.isEmpty) {
      return InputLabelPosition.internal;
    }
    return InputLabelPosition.external;
  }
}
