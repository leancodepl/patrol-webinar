import 'package:flutter/widgets.dart';

extension ResolveListDirectionality<T> on List<T> {
  List<T> resolve(TextDirection textDirection) {
    return switch (textDirection) {
      TextDirection.ltr => this,
      TextDirection.rtl => reversed.toList(),
    };
  }
}
