import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:app_design_system/src/styleguide/styleguide.dart';
import 'package:app_design_system/src/widgets/freeze_infinite_animations.dart';
import 'package:app_design_system/src/widgets/text/text.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

typedef PercentageValueBuilder =
    String? Function(BuildContext context, double value);

class AppLinearProgress extends StatelessWidget {
  const AppLinearProgress({
    super.key,
    required this.value,
    this.semanticsTitle,
    this.title,
    this.semanticsValue,
    this.valueBuilder = AppLinearProgress.percentageValueBuilder,
    this.animated = true,
  }) : assert(semanticsTitle != null || title != null);

  final double value;
  final String? semanticsTitle;
  final String? semanticsValue;
  final String? title;
  final PercentageValueBuilder? valueBuilder;
  final bool animated;

  static const _duration = Duration(milliseconds: 700);
  static const _curve = Curves.ease;

  static String percentageValueBuilder(BuildContext context, double value) {
    final l10n = context.l10n;

    return NumberFormat.percentPattern(l10n.localeName).format(value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

    final freezeAnimations = AppFreezeInfiniteAnimations.of(context);

    final effectiveValue = value.clamp(0.0, 1.0);

    final localizedPercentage = valueBuilder?.call(context, effectiveValue);

    final fallbackPercentageSemanticsValue = NumberFormat.percentPattern(
      l10n.localeName,
    ).format(value);

    return RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null || localizedPercentage != null) ...[
            ExcludeSemantics(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (title case final title?)
                    Expanded(
                      child: AppText(
                        title,
                        style: AppTextStyles.headlineSmall,
                        color: colors.foregroundDefaultPrimary,
                      ),
                    ),
                  if (localizedPercentage != null)
                    AppText(
                      localizedPercentage,
                      style: AppTextStyles.bodyDefault,
                      color: colors.foregroundDefaultSecondary,
                    ),
                ],
              ),
            ),
            AppSpacings.s8.verticalSpace,
          ],
          if (!freezeAnimations && animated)
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: effectiveValue),
              duration: _duration,
              curve: _curve,
              builder: (context, animatedValue, _) => _LinearProgressBar(
                value: animatedValue,
                semanticsTitle: semanticsTitle ?? title ?? '',
                semanticsValue:
                    semanticsValue ??
                    localizedPercentage ??
                    fallbackPercentageSemanticsValue,
              ),
            )
          else
            _LinearProgressBar(
              value: effectiveValue,
              semanticsTitle: semanticsTitle ?? title ?? '',
              semanticsValue:
                  semanticsValue ??
                  localizedPercentage ??
                  fallbackPercentageSemanticsValue,
            ),
        ],
      ),
    );
  }
}

class _LinearProgressBar extends StatelessWidget {
  const _LinearProgressBar({
    required this.value,
    required this.semanticsTitle,
    required this.semanticsValue,
  });

  final double value;
  final String semanticsTitle;
  final String semanticsValue;

  static const _barThickness = 4.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      label: semanticsTitle,
      value: semanticsValue,
      container: true,
      child: Container(
        height: _barThickness,
        decoration: BoxDecoration(
          color: colors.backgroundDefaultTertiary,
          borderRadius: BorderRadius.circular(_barThickness / 2),
        ),
        child: FractionallySizedBox(
          alignment: AlignmentDirectional.centerStart,
          widthFactor: value,
          child: Container(
            height: _barThickness,
            decoration: BoxDecoration(
              color: colors.foregroundActivePrimary,
              borderRadius: BorderRadius.circular(_barThickness / 2),
            ),
          ),
        ),
      ),
    );
  }
}
