import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' show Material, MaterialType, showDialog;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/common/util/spaced.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/agenda/models/speaker.dart';
import 'package:fts/features/rating/rate_cubit.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/context_snackbar_padding_extension.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class RateTalkPopup extends HookWidget {
  const RateTalkPopup._({required this.talk});

  static Future<void> show(BuildContext context, {required TalkSession talk}) =>
      showDialog<void>(
        context: context,
        builder: (context) => RateTalkPopup._(talk: talk),
      );

  final TalkSession talk;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    final rating = useState<int?>(null);
    final textController = useTextEditingController();

    final rateCubit = context.watch<RateCubit>();
    final state = rateCubit.state;

    useOnStreamChange(
      rateCubit.presentation,
      onData: (event) {
        switch (event) {
          case RateEvent.success:
            context.pop();
          case RateEvent.error:
            context.pushSnackbar(
              AppSnackbar(
                type: AppSnackbarType.danger,
                text: s.errorState_message,
                padding: context.snackbarPadding,
              ),
            );
        }
      },
    );

    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: MediaQuery.viewInsetsOf(context),
        child: Padding(
          padding: AppSpacings.s16.horizontal,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: AppSpacings.s24.all,
                decoration: BoxDecoration(
                  color: colors.backgroundDefaultPrimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: AppText(
                        s.ratePopup_title,
                        style: AppTextStyles.headlineSmall,
                        color: colors.foregroundDefaultPrimary,
                      ),
                    ),
                    AppSpacings.s12.verticalSpace,
                    _SessionTile(talk: talk),
                    AppSpacings.s24.verticalSpace,
                    _Stars(
                      rating: rating.value,
                      onChanged: (value) => rating.value = value,
                    ),
                    AppSpacings.s24.verticalSpace,
                    AppTextArea(
                      controller: textController,
                      textInputAction: TextInputAction.done,
                      decoration: AppTextAreaDecoration(
                        label: s.ratePopup_textFieldTitle,
                      ),
                    ),
                    AppSpacings.s24.verticalSpace,
                    AppButton(
                      caption: s.ratePopup_send,
                      isLoading: state == RateState.loading,
                      enabled: rating.value != null,
                      onTap: () {
                        rateCubit.rateSession(
                          sessionId: talk.id,
                          rating: rating.value!,
                          comment: textController.text.isNotEmpty
                              ? textController.text
                              : null,
                        );
                      },
                      type: AppButtonType.primary,
                      fullWidth: true,
                      analyticsId: AnalyticsIds.ratePopupSendButton,
                    ),
                    AppSpacings.s12.verticalSpace,
                    AppButton(
                      caption: s.common_cancel,
                      onTap: context.pop,
                      type: AppButtonType.secondary,
                      fullWidth: true,
                      analyticsId: AnalyticsIds.ratePopupCancelButton,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.talk});

  final TalkSession talk;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: AppSpacings.s16.all,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: colors.foregroundDefaultQuaternary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            talk.title,
            style: AppTextStyles.bodyDefault,
            color: colors.foregroundDefaultPrimary,
          ),
          AppSpacings.s12.verticalSpace,
          Column(
            children: [
              for (final speaker in talk.speakers)
                _SpeakerSection(speaker: speaker),
            ].spaced(AppSpacings.s8),
          ),
        ],
      ),
    );
  }
}

class _SpeakerSection extends StatelessWidget {
  const _SpeakerSection({required this.speaker});

  final Speaker speaker;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        if (speaker.photoUrl case final photoUrl?)
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: CachedNetworkImage(imageUrl: photoUrl.toString(), width: 42),
          ),
        AppSpacings.s8.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                speaker.fullName,
                style: AppTextStyles.bodyDefault,
                color: colors.foregroundDefaultPrimary,
              ),
              if (speaker.companyName case final companyName?)
                AppText(companyName, style: AppTextStyles.captionDefault),
            ],
          ),
        ),
      ],
    );
  }
}

class _Stars extends StatelessWidget {
  const _Stars({required this.rating, required this.onChanged});

  final int? rating;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 1; i <= RateCubit.maxRating; i++)
          AppButton.icon(
            icon: switch (rating) {
              final rating? when i <= rating => AppStandardIcons.starFilled01,
              _ => AppStandardIcons.star01,
            },
            size: AppButtonSize.medium,
            type: AppButtonType.tertiary,
            onTap: () => onChanged(i),
            analyticsId: AnalyticsIds.ratePopupStarButton,
            semanticsLabel: s.ratePopup_starButtonSemantics(
              rating: i,
              max: RateCubit.maxRating,
            ),
          ),
      ],
    );
  }
}
