import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/features/auth/common/resend_button_cubit.dart';
import 'package:fts/features/auth/common/seconds_left_builder.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';

class ResendButton extends StatelessWidget {
  const ResendButton({
    super.key,
    required this.onTap,
    required this.analyticsId,
  });

  final VoidCallback onTap;
  final AnalyticsId analyticsId;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    final state = context.watch<ResendButtonCubit>().state;

    return AnimatedSize(
      duration: Durations.short4,
      alignment: Alignment.topRight,
      child: switch (state.isButtonVisible) {
        true => Column(
          children: [
            AppSpacings.s16.verticalSpace,
            SecondsLeftBuilder(
              date: state.nextResendTime,
              refreshRate: const Duration(seconds: 1),
              builder: (context, secondsLeft) {
                final isEnabled = secondsLeft <= 0;
                return Row(
                  children: [
                    if (!isEnabled) ...[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.colors.foregroundDefaultTertiary,
                          ),
                        ),
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        child: AppText(
                          secondsLeft.toString(),
                          style: AppTextStyles.bodyDefault,
                        ),
                      ),
                      AppSpacings.s16.horizontalSpace,
                    ],
                    Flexible(
                      child: AppTextButton(
                        caption: s.resend_button_label,
                        type: AppTextButtonType.base,
                        enabled: isEnabled,
                        semanticsLabel: s.login_verify_account_resend_button,
                        analyticsId: analyticsId,
                        onTap: onTap,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        _ => const SizedBox(),
      },
    );
  }
}
