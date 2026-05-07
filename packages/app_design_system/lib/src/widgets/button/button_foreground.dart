import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/motion.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/widgets/button/icon_fade_transition.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:app_design_system/src/widgets/spinner/icon_spinner.dart';
import 'package:app_design_system/src/widgets/text/text_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
sealed class ButtonForegroundVariant with EquatableMixin {
  const ButtonForegroundVariant();

  String? get captionOrNull => switch (this) {
    ButtonForegroundCaption(:final caption) => caption,
    _ => null,
  };
}

final class ButtonForegroundCaption extends ButtonForegroundVariant {
  const ButtonForegroundCaption({
    required this.caption,
    this.leadingIcon,
    this.trailingIcon,
  });

  final String caption;
  final AppStandardIconData? leadingIcon;
  final AppStandardIconData? trailingIcon;

  @override
  List<Object?> get props => [caption, leadingIcon, trailingIcon];
}

final class ButtonForegroundIcon extends ButtonForegroundVariant {
  const ButtonForegroundIcon({required this.icon});

  final AppStandardIconData icon;

  @override
  List<Object?> get props => [icon];
}

@internal
class ButtonForeground extends StatelessWidget {
  const ButtonForeground({
    super.key,
    required this.spacing,
    required this.foregroundColor,
    required this.loading,
    required this.variant,
    required this.labelStyle,
    required this.curve,
    required this.duration,
  });

  final AppSpacing spacing;
  final AppColor foregroundColor;
  final bool loading;
  final AppTextStyle labelStyle;
  final Curve curve;
  final Duration duration;
  final ButtonForegroundVariant variant;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: labelStyle.getEffectiveHeight(context),
      ),
      child: TweenAnimationBuilder(
        tween: AppColorTween.uniform(foregroundColor),
        duration: duration,
        curve: curve,
        builder: (context, foregroundColor, _) => Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (variant case final ButtonForegroundIcon variant)
              _IconLoadingNullSwitcher(
                icon: variant.icon,
                foregroundColor: foregroundColor,
                loading: loading,
              )
            else if (variant case final ButtonForegroundCaption variant) ...[
              _IconLoadingNullSwitcher(
                icon: variant.leadingIcon,
                foregroundColor: foregroundColor,
                loading: loading,
              ),
              _AnimatedSpacing(
                visible: variant.leadingIcon != null || loading,
                spacing: spacing,
              ),
              Flexible(
                child: AppText(
                  variant.caption,
                  style: labelStyle,
                  color: foregroundColor,
                  maxLines: 1,
                ),
              ),
              _AnimatedSpacing(
                visible: variant.trailingIcon != null,
                spacing: spacing,
              ),
              _IconLoadingNullSwitcher(
                icon: variant.trailingIcon,
                foregroundColor: foregroundColor,
                loading: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _IconLoadingNullSwitcher extends StatelessWidget {
  const _IconLoadingNullSwitcher({
    required this.icon,
    required this.foregroundColor,
    required this.loading,
  });

  final AppStandardIconData? icon;
  final AppColor foregroundColor;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final iconWidget = switch (loading) {
      true => AppIconSpinner(color: foregroundColor),
      false => switch (icon) {
        final icon? => AppIcon(
          icon,
          size: AppStandardIconSize.s24,
          semanticsLabel: null,
          color: foregroundColor,
        ),
        _ => null,
      },
    };

    return IconFadeTransition(
      child: switch (iconWidget) {
        final iconWidget? => iconWidget,
        null => const SizedBox.shrink(),
      },
    );
  }
}

class _AnimatedSpacing extends StatelessWidget {
  const _AnimatedSpacing({required this.visible, required this.spacing});

  final bool visible;
  final AppSpacing spacing;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: AppDurations.fadeInOut,
      curve: AppCurves.fadeInOut,
      child: switch (visible) {
        true => spacing.horizontalSpace,
        false => AppSpacings.zero.horizontalSpace,
      },
    );
  }
}
