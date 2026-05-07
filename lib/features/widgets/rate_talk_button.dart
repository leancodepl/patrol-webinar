import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/rating/rate_cubit.dart';
import 'package:fts/features/rating/rate_talk_popup.dart';
import 'package:fts/features/rating/sign_up_to_rate_bottom_sheet.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/app_bottom_sheet.dart';
import 'package:fts/widgets/button/app_button.dart';

class RateTalkButton extends StatelessWidget {
  const RateTalkButton({super.key, required this.talk});

  final TalkSession talk;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    final userRating = talk.userRating;

    if (userRating == null) {
      return AppButton(
        caption: s.common_rateTalkButton,
        leadingIcon: AppStandardIcons.star01,
        type: AppButtonType.primary,
        fullWidth: true,
        onTap: () {
          final loggedIn = context.read<AuthCubit>().state is AuthStateLoggedIn;

          if (!loggedIn) {
            showAppBottomSheet<void>(
              context: context,
              builder: (context) => SignUpToRateBottomSheet(talk: talk),
            );
          } else {
            RateTalkPopup.show(context, talk: talk);
          }
        },
        analyticsId: AnalyticsIds.rateSessionButton,
      );
    } else {
      return Container(
        padding: AppSpacings.s12.all,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.foregroundDefaultQuaternary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              s.sessionTile_yourRating(
                stars: userRating,
                maxStars: RateCubit.maxRating,
              ),
              style: AppTextStyles.button,
            ),
            AppSpacings.s8.horizontalSpace,
            const AppIcon(
              AppStandardIcons.star01,
              size: AppStandardIconSize.s24,
              semanticsLabel: null,
            ),
          ],
        ),
      );
    }
  }
}
