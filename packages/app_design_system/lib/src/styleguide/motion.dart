import 'package:flutter/widgets.dart';

abstract class AppDurations {
  static const pointer = Duration(milliseconds: 250);

  static const fadeInOut = Duration(milliseconds: 250);
}

abstract class AppCurves {
  static const fadeInOut = Curves.ease;

  static const pointerEnter = Curves.easeOutCirc;
  static const pointerLeave = Curves.ease;
}
