import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/common/keys/page_ids.dart';
import 'package:fts/features/auth/common/auth_back_button.dart';
import 'package:fts/features/auth/common/terms_conditions_checkbox.dart';
import 'package:fts/features/auth/kratos/common/kratos_message_localized.dart';
import 'package:fts/features/auth/social/social_cubit.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';

class SocialTraitsForm extends StatelessWidget {
  const SocialTraitsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthBackButton(onTap: context.read<SocialCubit>().cancel),
              AppSpacings.s24.verticalSpace,
              Padding(
                padding: AppSpacings.s24.horizontal,
                child: const _SocialTraitsForm(),
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: AppSpacings.s24.horizontal,
            child: _SocialButton(),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socialCubit = context.read<SocialCubit>();
    final s = l10n(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          analyticsId: AnalyticsIds.socialContinueButton(PageId.register),
          caption: s.register,
          onTap: socialCubit.finishRegisterWithOidc,
          type: AppButtonType.primary,
        ),
        AppSpacings.s40.verticalSpace,
      ],
    );
  }
}

class _SocialTraitsForm extends StatelessWidget {
  const _SocialTraitsForm();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final socialCubit = context.watch<SocialCubit>();
    final generalError = socialCubit.state.generalError;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          s.register_fts,
          style: AppTextStyles.headlineLarge,
          color: context.colors.foregroundDefaultPrimary,
        ),
        AppSpacings.s24.verticalSpace,
        AppTextFormField(
          leadingIcon: AppStandardIcons.mail01,
          label: s.email_field,
          field: socialCubit.formCubit.email,
          translateError: (error) => error.localized(s, locale),
          textInputAction: TextInputAction.next,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
        ),
        AppSpacings.s24.verticalSpace,
        AppTextFormField(
          leadingIcon: AppStandardIcons.user01,
          label: s.register_first_name_field,
          field: socialCubit.formCubit.firstName,
          translateError: (error) => error.localized(s, locale),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
        ),
        AppSpacings.s24.verticalSpace,
        AppTextFormField(
          leadingIcon: AppStandardIcons.user01,
          label: s.register_family_name_field,
          field: socialCubit.formCubit.lastName,
          translateError: (error) => error.localized(s, locale),
          textCapitalization: TextCapitalization.words,
        ),
        AppSpacings.s24.verticalSpace,
        TermsConditionsCheckbox(field: socialCubit.formCubit.checkbox),
        AppSpacings.s24.verticalSpace,
        if (generalError != null)
          Padding(
            padding: AppSpacings.s16.top + AppSpacings.s4.bottom,
            child: AppText(
              switch (generalError) {
                SocialUnknownError() => s.register_unknown_error,
                SocialKratosGeneralError(:final error) => error.localized(
                  s,
                  locale,
                ),
              },
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyDefault,
            ),
          ),
      ],
    );
  }
}
