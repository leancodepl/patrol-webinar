import 'dart:math';

import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/divider.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:app_design_system/src/widgets/text/text.dart';
import 'package:boxy/boxy.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

enum AppSwitchType {
  /// The switch will take as little space as it needs to fit within the
  /// constraints. For example if the switch is wrapped with a widget that
  /// passes loose constraints (for example `Center`), the switch will take
  /// the minimum space needed.
  fit,

  /// The switch will take the maximum horizontal space available and minimum
  /// vertical space that fits within the constraints.
  fill,
}

class AppSwitch<T> extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.type,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final T value;
  final List<AppSwitchOption<T>> options;
  final AppSwitchType type;
  final ValueChanged<T> onChanged;

  bool _isSelected(AppSwitchOption<T> option) => option.value == value;

  @override
  Widget build(BuildContext context) {
    final offstageDividers = type != AppSwitchType.fill;
    final textDirection = Directionality.of(context);
    const indicatorId = _IndicatorId();

    final optionsDirectional = switch (textDirection) {
      TextDirection.ltr => options,
      TextDirection.rtl => options.reversed.toList(),
    };

    final currentIndex = optionsDirectional.indexWhere(_isSelected).toDouble();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colors.backgroundDefaultSecondary,
      ),
      padding: AppSpacings.s4.all,
      child: TweenAnimationBuilder(
        tween: Tween<double>(end: currentIndex),
        curve: Curves.ease,
        duration: const Duration(milliseconds: 250),
        builder: (context, progress, _) {
          return IntrinsicHeight(
            child: CustomBoxy(
              delegate: switch (type) {
                AppSwitchType.fit => _FitLayoutDelegate(
                  current: progress,
                  indicatorId: indicatorId,
                ),
                AppSwitchType.fill => _FillLayoutDelegate(
                  current: progress,
                  indicatorId: indicatorId,
                ),
              },
              children: [
                ...optionsDirectional
                    .skip(1)
                    .mapIndexed(
                      (index, _) => BoxyId(
                        id: _DividerId(index),
                        child: Offstage(
                          offstage: offstageDividers,
                          child: Padding(
                            padding: AppSpacings.s4.vertical,
                            child: const AppDivider.vertical(),
                          ),
                        ),
                      ),
                    ),
                BoxyId(
                  id: indicatorId,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.backgroundDefaultPrimary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                ...optionsDirectional.mapIndexed(
                  (index, option) => BoxyId(
                    id: _OptionId(index),
                    child: _Option(
                      option: option,
                      selected: _isSelected(option),
                      onTap: () => onChanged(option.value),
                      semanticsIndex: index + 1,
                      semanticsTotalOptions: optionsDirectional.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

sealed class AppSwitchOption<T> {
  const factory AppSwitchOption.text({
    Key key,
    required String text,
    required T value,
    String? semanticsLabel,
  }) = _SwitchOptionText;

  const factory AppSwitchOption.icon({
    Key key,
    required AppStandardIconData icon,
    required T value,
    required String semanticsLabel,
  }) = _SwitchOptionIcon;

  const AppSwitchOption._({this.key, required this.value});

  final Key? key;
  final T value;
}

final class _SwitchOptionText<T> extends AppSwitchOption<T> {
  const _SwitchOptionText({
    super.key,
    required super.value,
    required this.text,
    this.semanticsLabel,
  }) : super._();

  final String text;
  final String? semanticsLabel;
}

final class _SwitchOptionIcon<T> extends AppSwitchOption<T> {
  const _SwitchOptionIcon({
    super.key,
    required super.value,
    required this.icon,
    required this.semanticsLabel,
  }) : super._();

  final AppStandardIconData icon;
  final String semanticsLabel;
}

class _Option<T> extends StatelessWidget {
  const _Option({
    super.key,
    required this.option,
    required this.selected,
    required this.onTap,
    required this.semanticsIndex,
    required this.semanticsTotalOptions,
  });

  final AppSwitchOption<T> option;
  final bool selected;
  final VoidCallback onTap;
  final int semanticsIndex;
  final int semanticsTotalOptions;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

    return Semantics(
      selected: selected,
      child: AppPointerSurface(
        key: option.key,
        enabled: true,
        onTap: onTap,
        builder: (context, _) => Stack(
          fit: StackFit.passthrough,
          children: [
            Padding(
              padding: AppSpacings.s16.horizontal + AppSpacings.s4.vertical,
              child: Center(
                child: switch (option) {
                  _SwitchOptionText(:final text) => AppText(
                    text,
                    style: AppTextStyles.bodyDefault,
                    color: colors.foregroundDefaultSecondary,
                    maxLines: 1,
                    ellipsis: false,
                  ),
                  _SwitchOptionIcon(:final icon, :final semanticsLabel) =>
                    Semantics(
                      label: semanticsLabel,
                      child: AppIcon(
                        icon,
                        size: AppStandardIconSize.s24,
                        color: colors.foregroundDefaultSecondary,
                        semanticsLabel: null,
                      ),
                    ),
                },
              ),
            ),
            Semantics(
              label: l10n.switch_optionOfTotal(
                semanticsIndex,
                semanticsTotalOptions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionId with EquatableMixin {
  const _OptionId(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

class _DividerId with EquatableMixin {
  const _DividerId(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

class _IndicatorId with EquatableMixin {
  const _IndicatorId();

  @override
  List<Object> get props => [];
}

abstract class _LayoutDelegate extends BoxyDelegate {
  _LayoutDelegate({required this.current, required this.indicatorId});

  final double current;
  final _IndicatorId indicatorId;

  List<BoxyChild> getOptions() => [
    ...children.where((child) => child.id is _OptionId),
  ];

  List<BoxyChild> getDividers() => [
    ...children.where((child) => child.id is _DividerId),
  ];

  List<BoxyChild> getOptionsAndDividers() {
    final options = getOptions();

    return options.expandIndexed((index, option) {
      return [
        option,
        if (index < options.length - 1) getChild(_DividerId(index)),
      ];
    }).toList();
  }

  // We calculate the effective size of the switch by taking the sum of the
  // width of all the options and dividers. We also take the maximum height of
  // all the children.
  Size getEffectiveSize() {
    return getOptionsAndDividers().fold(Size.zero, (childSize, child) {
      final size = Size(
        childSize.width + child.render.size.width,
        max(childSize.height, child.render.size.height),
      );
      return constraints.constrain(size);
    });
  }

  Size layoutAndPositionDivider(BoxyChild divider, {required Offset offset}) {
    divider
      ..layout(constraints.loosen())
      ..position(offset);

    return divider.size;
  }

  Size layoutAndPositionIndicator() {
    final indicator = getChild(indicatorId);
    final lhsRect = getRectForIndicator(_OptionId(current.floor()));
    final rhsRect = getRectForIndicator(_OptionId(current.ceil()));
    final mantissa = current - current.floor();

    // We interpolate between the left and right rect to get the final rect for
    // the indicator.
    final indicatorRect =
        RectTween(
          begin: lhsRect,
          end: rhsRect,
        ).evaluate(AlwaysStoppedAnimation(mantissa)) ??
        Rect.zero;

    indicator
      ..layout(BoxConstraints.tight(indicatorRect.size))
      ..position(indicatorRect.topLeft);

    return indicator.size;
  }

  Rect getRectForIndicator(_OptionId id) {
    var rect = getChild(id).rect;
    final leftDivider = getChildOrNull(_DividerId(id.index - 1));
    final rightDivider = getChildOrNull(_DividerId(id.index));

    if (leftDivider case final divider?) {
      rect = rect.expandToInclude(divider.rect);
    }

    if (rightDivider case final divider?) {
      rect = rect.expandToInclude(divider.rect);
    }

    return rect;
  }

  @override
  double minIntrinsicHeight(double width) => getOptionsAndDividers()
      .map((child) => child.render.getMinIntrinsicHeight(width))
      .max;

  @override
  double maxIntrinsicHeight(double width) => getOptionsAndDividers()
      .map((child) => child.render.getMaxIntrinsicHeight(width))
      .max;

  @override
  double minIntrinsicWidth(double height) => getOptionsAndDividers()
      .map((child) => child.render.getMinIntrinsicWidth(height))
      .sum;

  @override
  double maxIntrinsicWidth(double height) => getOptionsAndDividers()
      .map((child) => child.render.getMaxIntrinsicWidth(height))
      .sum;

  @override
  bool shouldRelayout(_LayoutDelegate oldDelegate) =>
      current != oldDelegate.current || indicatorId != oldDelegate.indicatorId;
}

class _FitLayoutDelegate extends _LayoutDelegate {
  _FitLayoutDelegate({required super.current, required super.indicatorId});

  @override
  Size layout() {
    final optionsAndDividers = getOptionsAndDividers();
    final totalIntrinsicWidth = optionsAndDividers.map((child) {
      return child.render.getMinIntrinsicWidth(constraints.maxHeight);
    }).sum;

    // We calculate the effective width of the switch by taking the sum of the
    // width of all the options and dividers. We then calculate the scale factor
    // to fit all the children within the constraints.
    final effectiveWidth = constraints.constrainWidth(totalIntrinsicWidth);
    final widthScale = effectiveWidth / totalIntrinsicWidth;

    Size layoutAndPositionOption(BoxyChild option, {required Offset offset}) {
      final intrinsicWidth = option.render.getMinIntrinsicWidth(
        constraints.maxHeight,
      );
      final width = intrinsicWidth * widthScale;
      final childConstraints = BoxConstraints(
        maxWidth: width,
        maxHeight: constraints.maxHeight,
      );

      option
        ..layout(childConstraints)
        ..position(offset);

      return option.size;
    }

    // First we layout and position all the options and dividers. We keep track
    // of the current offset to position the next child.
    var currentOffset = Offset.zero;
    for (final child in optionsAndDividers) {
      final size = switch (child.id) {
        _DividerId() => layoutAndPositionDivider(child, offset: currentOffset),
        _OptionId() => layoutAndPositionOption(child, offset: currentOffset),
        _ => Size.zero,
      };
      currentOffset += Offset(size.width, 0);
    }

    layoutAndPositionIndicator();

    return getEffectiveSize();
  }
}

class _FillLayoutDelegate extends _LayoutDelegate {
  _FillLayoutDelegate({required super.current, required super.indicatorId});

  @override
  Size layout() {
    final dividers = getDividers();
    final options = getOptions();
    final optionsAndDividers = getOptionsAndDividers();

    // We calculate the total width of all the dividers to subtract from the
    // total width of the switch to get the total width of all the options.
    final totalDividersWidth = dividers.map((divider) {
      return divider.render.getMinIntrinsicWidth(constraints.maxHeight);
    }).sum;
    final totalOptionsWidth = constraints.maxWidth - totalDividersWidth;

    // We assign an equal width to all the options.
    final optionWidth = totalOptionsWidth / options.length;

    Size layoutAndPositionOption(BoxyChild option, {required Offset offset}) {
      final childConstraints = BoxConstraints(
        maxWidth: optionWidth,
        maxHeight: constraints.maxHeight,
      );

      option
        ..layout(childConstraints)
        ..position(offset);

      return option.size;
    }

    // First we layout and position all the options and dividers. We keep track
    // of the current offset to position the next child.
    var currentOffset = Offset.zero;
    for (final child in optionsAndDividers) {
      final size = switch (child.id) {
        _DividerId() => layoutAndPositionDivider(child, offset: currentOffset),
        _OptionId() => layoutAndPositionOption(child, offset: currentOffset),
        _ => Size.zero,
      };
      currentOffset += Offset(size.width, 0);
    }

    layoutAndPositionIndicator();

    return getEffectiveSize();
  }
}
