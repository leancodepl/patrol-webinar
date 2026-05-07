import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class ChipRemoveIconButton extends StatelessWidget {
  const ChipRemoveIconButton({
    super.key,
    this.enabled = true,
    required this.onTap,
    required this.size,
  });

  final bool enabled;
  final VoidCallback onTap;
  final AppIconSize size;

  static const duration = Duration(milliseconds: 250);
  static const curve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;

    return Semantics(
      button: true,
      enabled: enabled,
      excludeSemantics: true,
      label: l10n.chip_remove,
      onTap: onTap,
      child: AppPointerSurface(
        enabled: enabled,
        onTap: onTap,
        builder: (context, state) {
          final resolvedColors = _resolveColors(
            colors,
            pressed: state.containsPressed,
          );

          return _ChipRemoveButtonColorsTween(
            backgroundColor: resolvedColors.backgroundColor,
            iconColor: resolvedColors.iconColor,
            builder: (context, backgroundColor, iconColor) {
              return Container(
                margin: const EdgeInsetsDirectional.all(4),
                padding: const EdgeInsetsDirectional.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundColor,
                ),
                child: AppIcon(
                  AppStandardIcons.x,
                  size: size,
                  semanticsLabel: null,
                  color: iconColor,
                ),
              );
            },
          );
        },
      ),
    );
  }

  _ChipRemoveButtonColors _resolveColors(
    AppColors colors, {
    required bool pressed,
  }) {
    if (!enabled) {
      return (
        iconColor: colors.foregroundDisabledSecondary,
        backgroundColor: colors.transparent,
      );
    }

    return (
      iconColor: pressed
          ? colors.foregroundDefaultSecondaryPressed
          : colors.foregroundDefaultPrimary,
      backgroundColor: pressed
          ? colors.backgroundDefaultPrimaryPressed
          : colors.transparent,
    );
  }
}

typedef _ChipRemoveButtonColors = ({
  AppColor iconColor,
  AppColor backgroundColor,
});

typedef _ChipRemoveButtonColorsTweenBuilder =
    Widget Function(
      BuildContext context,
      AppColor backgroundColor,
      AppColor iconColor,
    );

class _ChipRemoveButtonColorsTween extends ImplicitlyAnimatedWidget {
  const _ChipRemoveButtonColorsTween({
    required this.backgroundColor,
    required this.iconColor,
    required this.builder,
  }) : super(duration: _duration, curve: _curve);

  static const _duration = Duration(milliseconds: 150);
  static const _curve = Curves.ease;

  final AppColor backgroundColor;
  final AppColor iconColor;
  final _ChipRemoveButtonColorsTweenBuilder builder;

  @override
  ChipRemoveButtonColorsTweenState createState() =>
      ChipRemoveButtonColorsTweenState();
}

@internal
class ChipRemoveButtonColorsTweenState
    extends AnimatedWidgetBaseState<_ChipRemoveButtonColorsTween> {
  AppColorTween? _backgroundColor;
  AppColorTween? _iconColor;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _backgroundColor =
        visitor(
              _backgroundColor,
              widget.backgroundColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    final iconColor = widget.iconColor;
    _iconColor =
        visitor(
              _iconColor,
              iconColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _backgroundColor!.evaluate(animation),
      _iconColor!.evaluate(animation),
    );
  }
}
