import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/config/app_global_keys.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/rating/rate_talk_popup.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/app_bottom_sheet.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class SignUpToRateBottomSheet extends StatelessWidget {
  const SignUpToRateBottomSheet({super.key, required this.talk});

  final TalkSession talk;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final colors = context.colors;

    return AppBottomSheet(
      title: AppText(
        s.signUpToRateTile_title,
        style: AppTextStyles.headlineMedium,
        color: colors.foregroundDefaultPrimary,
      ),
      content: Column(
        children: [
          AppText(s.signUpToRateTile_message, style: AppTextStyles.bodyDefault),
          AppSpacings.s24.verticalSpace,
          AppButton(
            caption: s.register,
            type: AppButtonType.primary,
            fullWidth: true,
            onTap: () async {
              final kratosClient = context.read<KratosClient>();
              final navigatorContext = context
                  .read<AppGlobalKeys>()
                  .navigatorKey
                  .currentContext;
              context.pop();

              await const RegisterRoute().push<void>(context);
              // Ideally, the check should be done by waiting for the auth cubit
              // to emit the state, but this causes a race condition with popUntil,
              // which pops the dialog immediately after its shown
              if (await kratosClient.isSessionValid()
                  case SessionValiditySuccessResult(isValid: true)
                  when navigatorContext != null && navigatorContext.mounted) {
                await RateTalkPopup.show(navigatorContext, talk: talk);
              }
            },
            analyticsId: AnalyticsIds.signUpToRateButton,
          ),
          AppSpacings.s16.verticalSpace,
          AppButton(
            caption: s.common_cancel,
            type: AppButtonType.secondary,
            fullWidth: true,
            onTap: context.pop,
            analyticsId: AnalyticsIds.signUpToRateCancelButton,
          ),
          AppSpacings.s32.verticalSpace,
        ],
      ),
    );
  }
}
