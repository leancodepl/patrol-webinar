import 'package:app_design_system/src/styleguide/styleguide.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:app_design_system/src/widgets/text/text_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class SelectionControlTileBase extends StatelessWidget {
  const SelectionControlTileBase({
    super.key,
    required this.enabled,
    required this.selected,
    required this.label,
    required this.description,
    required this.value,
    required this.trailingIcon,
    required this.selectionControl,
    required this.onTap,
  });

  final bool enabled;
  final bool selected;
  final String label;
  final String? description;
  final String? value;
  final AppStandardIconData? trailingIcon;
  final Widget? selectionControl;
  final VoidCallback onTap;

  static const _borderRadius = 4.0;
  static const _borderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: AppPointerSurface(
        enabled: enabled,
        onTap: onTap,
        builder: (context, states) => _SelectionControlTileColorsTween(
          colors: context.colors,
          enabled: enabled,
          pressed: states.containsPressed,
          selected: selected,
          builder:
              (
                context,
                foregroundPrimaryColor,
                foregroundSecondaryColor,
                borderColor,
                backgroundColor,
              ) => _TileContents(
                label: label,
                description: description,
                value: value,
                trailingIcon: trailingIcon,
                selectionControl: selectionControl,
                onTap: onTap,
                foregroundPrimaryColor: foregroundPrimaryColor,
                foregroundSecondaryColor: foregroundSecondaryColor,
                borderColor: borderColor,
                backgroundColor: backgroundColor,
              ),
        ),
      ),
    );
  }
}

class _TileContents extends StatelessWidget {
  const _TileContents({
    required this.label,
    required this.description,
    required this.value,
    required this.trailingIcon,
    required this.selectionControl,
    required this.onTap,
    required this.foregroundPrimaryColor,
    required this.foregroundSecondaryColor,
    required this.borderColor,
    required this.backgroundColor,
  });

  final String label;
  final String? description;
  final String? value;
  final AppStandardIconData? trailingIcon;
  final Widget? selectionControl;
  final VoidCallback onTap;
  final AppColor foregroundPrimaryColor;
  final AppColor foregroundSecondaryColor;
  final AppColor borderColor;
  final AppColor backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: SelectionControlTileBase._borderWidth,
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(
          SelectionControlTileBase._borderRadius,
        ),
        color: backgroundColor,
      ),
      padding: AppSpacings.s16.all,
      child: Row(
        spacing: AppSpacings.s8.value,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectionControl case final selectionControl?)
            AbsorbPointer(child: selectionControl),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final maxValueWidth = 0.75 * constraints.maxWidth;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppText(
                            label,
                            style: AppTextStyles.bodyDefault,
                            color: foregroundPrimaryColor,
                          ),
                        ),
                        if (value case final value?)
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: maxValueWidth,
                            ),
                            child: AppText(
                              value,
                              style: AppTextStyles.bodyDefault,
                              color: foregroundSecondaryColor,
                              textAlign: TextAlign.end,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                if (description case final description?)
                  AppText(
                    description,
                    style: AppTextStyles.captionDefault,
                    color: foregroundSecondaryColor,
                  ),
              ],
            ),
          ),
          if (trailingIcon case final trailingIcon?)
            AppIcon(
              trailingIcon,
              color: foregroundSecondaryColor,
              size: AppStandardIconSize.s24,
              semanticsLabel: null,
            ),
        ],
      ),
    );
  }
}

class _SelectionControlTileColorsTween extends ImplicitlyAnimatedWidget {
  const _SelectionControlTileColorsTween({
    required this.builder,
    required this.colors,
    required this.enabled,
    required this.pressed,
    required this.selected,
  }) : super(duration: _duration, curve: _curve);

  final AppColors colors;
  final bool enabled;
  final bool pressed;
  final bool selected;
  final Widget Function(
    BuildContext context,
    AppColor primaryForegroundColor,
    AppColor secondaryForegroundColor,
    AppColor borderColor,
    AppColor backgroundColor,
  )
  builder;

  static const _duration = Duration(milliseconds: 150);
  static const _curve = Curves.ease;

  @override
  _SelectionControlTileColorsTweenState createState() =>
      _SelectionControlTileColorsTweenState();
}

class _SelectionControlTileColorsTweenState
    extends AnimatedWidgetBaseState<_SelectionControlTileColorsTween> {
  AppColorTween? _primaryForegroundColor;
  AppColorTween? _secondaryForegroundColor;
  AppColorTween? _borderColor;
  AppColorTween? _backgroundColor;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    final colors = _resolveColors();

    _primaryForegroundColor =
        visitor(
              _primaryForegroundColor,
              colors.primaryForegroundColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    _secondaryForegroundColor =
        visitor(
              _secondaryForegroundColor,
              colors.secondaryForegroundColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    _borderColor =
        visitor(
              _borderColor,
              colors.borderColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    _backgroundColor =
        visitor(
              _backgroundColor,
              colors.backgroundColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _primaryForegroundColor!.evaluate(animation),
      _secondaryForegroundColor!.evaluate(animation),
      _borderColor!.evaluate(animation),
      _backgroundColor!.evaluate(animation),
    );
  }

  ({
    AppColor primaryForegroundColor,
    AppColor secondaryForegroundColor,
    AppColor borderColor,
    AppColor backgroundColor,
  })
  _resolveColors() {
    final colors = widget.colors;

    return switch (widget.enabled) {
      true => switch (widget.selected) {
        true => switch (widget.pressed) {
          true => (
            primaryForegroundColor: colors.foregroundActivePrimary,
            secondaryForegroundColor: colors.foregroundActiveSecondary,
            borderColor: colors.foregroundActiveSecondaryPressed,
            backgroundColor: colors.backgroundActiveTertiaryPressed,
          ),
          false => (
            primaryForegroundColor: colors.foregroundActivePrimary,
            secondaryForegroundColor: colors.foregroundActiveSecondary,
            borderColor: colors.foregroundActiveSecondary,
            backgroundColor: colors.backgroundActiveTertiary,
          ),
        },
        false => switch (widget.pressed) {
          true => (
            primaryForegroundColor: colors.foregroundActivePrimary,
            secondaryForegroundColor: colors.foregroundActiveSecondary,
            borderColor: colors.foregroundActiveQuaternary,
            backgroundColor: colors.backgroundDefaultPrimaryPressed,
          ),
          false => (
            primaryForegroundColor: colors.foregroundActivePrimary,
            secondaryForegroundColor: colors.foregroundActiveSecondary,
            borderColor: colors.foregroundDefaultQuaternary,
            backgroundColor: colors.backgroundDefaultPrimary,
          ),
        },
      },
      false => switch (widget.selected) {
        true => (
          primaryForegroundColor: colors.foregroundDisabledPrimary,
          secondaryForegroundColor: colors.foregroundDisabledSecondary,
          borderColor: colors.foregroundDisabledPrimary,
          backgroundColor: colors.backgroundDisabledTertiary,
        ),
        false => (
          primaryForegroundColor: colors.foregroundDisabledPrimary,
          secondaryForegroundColor: colors.foregroundDisabledSecondary,
          borderColor: colors.foregroundDisabledTertiary,
          backgroundColor: colors.backgroundDefaultPrimary,
        ),
      },
    };
  }
}
