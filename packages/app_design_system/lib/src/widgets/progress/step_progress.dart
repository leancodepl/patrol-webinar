import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/widgets/freeze_infinite_animations.dart';
import 'package:app_design_system/src/widgets/text/text_widget.dart';
import 'package:flutter/widgets.dart';

typedef FractionValueBuilder =
    String? Function(
      BuildContext context,
      int currentStepIndex,
      int totalSteps,
    );

class AppStepProgress extends StatelessWidget {
  const AppStepProgress({
    super.key,
    required this.totalSteps,
    required this.currentStepIndex,
    this.semanticsTitle,
    this.semanticsValue,
    this.title,
    this.valueBuilder = AppStepProgress.defaultValueBuilder,
    this.animateInitialState = true,
  });

  final int currentStepIndex;
  final int totalSteps;
  final String? semanticsTitle;
  final String? semanticsValue;
  final String? title;
  final FractionValueBuilder? valueBuilder;
  final bool animateInitialState;

  static const _duration = Duration(milliseconds: 500);
  static const _curve = Curves.ease;

  static String defaultValueBuilder(
    BuildContext context,
    int currentStepIndex,
    int totalSteps,
  ) {
    final l10n = context.l10n;

    return l10n.appStepProgress_defaultValueBuilder(
      currentStepIndex,
      totalSteps,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final freezeAnimations = AppFreezeInfiniteAnimations.of(context);

    final effectiveTotalSteps = totalSteps == 0 ? 1 : totalSteps;

    final progress = currentStepIndex.clamp(0, effectiveTotalSteps);

    final localizedFractionValue = valueBuilder?.call(
      context,
      progress,
      effectiveTotalSteps,
    );

    final effectiveSemanticsTitle = semanticsTitle ?? title ?? '';
    final effectiveSemanticsValue =
        semanticsValue ??
        localizedFractionValue ??
        defaultValueBuilder(context, currentStepIndex, totalSteps);

    return RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null || localizedFractionValue != null) ...[
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
                  if (localizedFractionValue != null)
                    AppText(
                      localizedFractionValue,
                      style: AppTextStyles.bodyDefault,
                      color: colors.foregroundDefaultSecondary,
                    ),
                ],
              ),
            ),
            AppSpacings.s8.verticalSpace,
          ],
          if (freezeAnimations)
            _StepProgressBody(
              totalSteps: effectiveTotalSteps,
              progress: progress.toDouble(),
              semanticsTitle: effectiveSemanticsTitle,
              semanticsValue: effectiveSemanticsValue,
            )
          else
            TweenAnimationBuilder(
              tween: Tween(
                begin: animateInitialState ? 0.0 : progress,
                end: progress,
              ),
              duration: _duration,
              curve: _curve,
              builder: (context, animatedProgress, _) => _StepProgressBody(
                totalSteps: effectiveTotalSteps,
                progress: animatedProgress.toDouble(),
                semanticsTitle: effectiveSemanticsTitle,
                semanticsValue: effectiveSemanticsValue,
              ),
            ),
        ],
      ),
    );
  }
}

class _StepProgressBody extends StatelessWidget {
  const _StepProgressBody({
    required this.progress,
    required this.totalSteps,
    required this.semanticsTitle,
    required this.semanticsValue,
  });

  final double progress;
  final int totalSteps;
  final String semanticsTitle;
  final String semanticsValue;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsTitle,
      value: semanticsValue,
      container: true,
      child: Row(
        children: [
          for (var i = 0; i < totalSteps; i++) ...[
            Expanded(
              child: _StepPill(totalProgress: progress, index: i),
            ),
            if (i < totalSteps - 1) AppSpacings.s4.horizontalSpace,
          ],
        ],
      ),
    );
  }
}

class _StepPill extends StatelessWidget {
  const _StepPill({required this.totalProgress, required this.index});

  final double totalProgress;
  final int index;

  static const thickness = 4.0;
  static final borderRadius = BorderRadius.circular(thickness / 2);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final localProgress = (totalProgress - index).clamp(0.0, 1.0);

    return Container(
      height: thickness,
      decoration: BoxDecoration(
        color: colors.backgroundDefaultTertiary,
        borderRadius: borderRadius,
      ),
      child: FractionallySizedBox(
        alignment: AlignmentDirectional.centerStart,
        widthFactor: localProgress,
        child: Container(
          height: thickness,
          decoration: BoxDecoration(
            color: colors.foregroundActivePrimary,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}
