import 'package:app_design_system/src/utils/geometry.dart';
import 'package:app_design_system/src/widgets/tooltip/tooltip.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class TooltipController extends ChangeNotifier {
  TooltipController({bool isVisible = false}) : _isVisible = isVisible;

  bool _isVisible;
  TooltipMetrics? _metrics;

  bool get isVisible => _isVisible;
  TooltipMetrics? get metrics => _metrics;

  void show() {
    _isVisible = true;
    notifyListeners();
  }

  void hide() {
    _isVisible = false;
    notifyListeners();
  }

  void toggle() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  void updateMetrics(TooltipMetrics metrics) {
    if (_metrics == metrics) {
      return;
    }

    _metrics = metrics;
    notifyListeners();
  }
}

@internal
class TooltipMetrics with EquatableMixin {
  const TooltipMetrics({required this.registryRect, required this.targetRect});

  /// The rectangle of the [AppTooltipRegistry].
  final Rect registryRect;

  /// The rectangle of the target widget that the tooltip is pointing to.
  final Rect targetRect;

  Rect get shiftedTargetRect => targetRect.constrainWithin(registryRect);

  bool get isOutOfBounds => shiftedTargetRect != targetRect;

  @override
  List<Object?> get props => [registryRect, targetRect];
}
