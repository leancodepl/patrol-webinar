import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/common/util/app_platform.dart';
import 'package:fts/common/util/spaced.dart';
import 'package:fts/features/auth/common/auth_back_button.dart';
import 'package:fts/features/auth/common/caption_divider.dart';
import 'package:fts/features/auth/common/small_social_button.dart';
import 'package:fts/features/auth/common/terms_conditions_checkbox.dart';
import 'package:fts/features/auth/kratos/common/kratos_message_localized.dart';
import 'package:fts/features/auth/register/register_cubit.dart';
import 'package:fts/features/auth/social/social_cubit.dart';
import 'package:fts/features/auth/social/social_traits_form.dart';
import 'package:fts/features/connectivity/connectivity_banner.dart';
import 'package:fts/keys.dart';
import 'package:fts/navigation/navigate_after_login.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/context_snackbar_padding_extension.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubit(
            kratosClient: context.read(),
            authCubit: context.read(),
            passkeyCredentialManager: context.read(),
          ),
        ),
        BlocProvider(
          create: (context) => SocialCubit(
            appLifecycleProvider: context.read(),
            kratosClient: context.read(),
            authCubit: context.read(),
          )..init(),
        ),
      ],
      child: const _RegisterWithCredentialsContent(),
    );
  }
}

class _RegisterWithCredentialsContent extends HookWidget {
  const _RegisterWithCredentialsContent();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    void navigateToEmailVerification(String? email, String? flowId) =>
        VerifyRoute(email: email, flowId: flowId).push<void>(context);

    useOnStreamChange(
      context.watch<RegisterCubit>().presentation,
      onData: (event) => switch (event) {
        RegisterEventSuccess() => navigateAfterLogin(context),
        RegisterEventVerifyEmail(:final email, :final flowId) =>
          navigateToEmailVerification(email, flowId),
      },
    );

    useOnStreamChange(
      context.watch<SocialCubit>().presentation,
      onData: (event) {
        switch (event) {
          case SocialEventSuccess():
            navigateAfterLogin(context);
          case SocialEventVerifyEmail(:final email, :final flowId):
            navigateToEmailVerification(email, flowId);
          case SocialEventAccountExists():
            context.pushSnackbar(
              AppSnackbar(
                type: AppSnackbarType.warning,
                text: s.login_login_method_not_added_to_account_message,
                padding: context.snackbarPadding,
              ),
            );
            const LoginRoute().push<void>(context);
        }
      },
    );

    final registerState = context.read<RegisterCubit>().state;
    final socialState = context.read<SocialCubit>().state;

    return AppScaffold(
      useBodyPadding: false,
      body: AppLoadingOverlay(
        isLoading: registerState.inProgress || socialState.inProgress,
        child: BlocBuilder<SocialCubit, SocialState>(
          builder: (context, state) => switch (state) {
            SocialStateIdle() => const _RegisterWidget(),
            SocialStateTraitsStep() => const SocialTraitsForm(),
          },
        ),
      ),
    );
  }
}

class _RegisterWidget extends StatelessWidget {
  const _RegisterWidget();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: ConnectivityBanner()),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthBackButton(onTap: context.pop),
                  AppSpacings.s24.verticalSpace,
                  Padding(
                    padding: AppSpacings.s24.horizontal,
                    child: _buildForm(state),
                  ),
                ],
              ),
            ),
            if (state is RegisterStateProfileEnter)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: AppSpacings.s24.horizontal,
                  child: Column(
                    children: [
                      _RegisterProfileButtons(),
                      CaptionDivider(
                        caption: s.registerPage_alreadyHaveAnAccount,
                      ),
                      AppSpacings.s24.verticalSpace,
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          key: keys.loginPage.loginButtonOnRegisterPage,
                          analyticsId: AnalyticsIds.loginButton,
                          caption: s.login_button,
                          onTap: () => const LoginRoute().push<void>(context),
                          type: AppButtonType.secondary,
                        ),
                      ),
                      AppSpacings.s12.verticalSpace,
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildForm(RegisterState state) {
    switch (state) {
      case RegisterStateProfileEnter():
        return _RegisterProfileForm(state);
      case RegisterStatePasswordEnter():
        return _RegisterPasswordForm(state);
    }
  }
}

class _RegisterProfileButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final registerCubit = context.read<RegisterCubit>();
    final socialError = context.read<SocialCubit>().state.generalError;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: double.infinity,
          child: AppButton(
            key: keys.registerPage.registerButton,
            caption: s.register,
            onTap: registerCubit.registerProfile,
            analyticsId: AnalyticsIds.recoveryEmailButton,
            type: AppButtonType.primary,
          ),
        ),
        AppSpacings.s24.verticalSpace,
        CaptionDivider(caption: s.register_other_methods),
        AppSpacings.s24.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (AppPlatform.platform.isAndroid)
              SmallGoogleButton(
                onTap: () => context.read<SocialCubit>().registerWithOidc(
                  OidcProvider.google,
                ),
                analyticsId: AnalyticsIds.registerWithGoogleButton,
              ),
            if (AppPlatform.platform.isIos)
              SmallAppleButton(
                onTap: () => context.read<SocialCubit>().registerWithOidc(
                  OidcProvider.apple,
                ),
                analyticsId: AnalyticsIds.registerWithAppleButton,
              ),
          ].spaced(AppSpacings.s24, Axis.horizontal),
        ),
        if (socialError != null)
          Padding(
            padding: AppSpacings.s16.top + AppSpacings.s4.bottom,
            child: AppText(
              switch (socialError) {
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
        AppSpacings.s40.verticalSpace,
      ],
    );
  }
}

class _RegisterProfileForm extends StatelessWidget {
  const _RegisterProfileForm(this.state);

  final RegisterStateProfileEnter state;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final profileFormCubit = context.read<RegisterCubit>().profileFormCubit;
    final generalError = state.generalError;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          s.register_fts,
          style: AppTextStyles.headlineLarge,
          color: context.colors.foregroundDefaultPrimary,
        ),
        AppSpacings.s24.verticalSpace,
        const AppStepProgress(
          totalSteps: 2,
          currentStepIndex: 1,
          valueBuilder: null,
        ),
        AppSpacings.s24.verticalSpace,
        AppTextFormField(
          key: keys.registerPage.emailField,
          leadingIcon: AppStandardIcons.mail01,
          label: s.email_field,
          field: profileFormCubit.email,
          translateError: (error) => error.localized(s, locale),
          textInputAction: TextInputAction.next,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
        ),
        AppSpacings.s24.verticalSpace,
        AppTextFormField(
          key: keys.registerPage.firstNameField,
          leadingIcon: AppStandardIcons.user01,
          label: s.register_first_name_field,
          field: profileFormCubit.firstName,
          translateError: (error) => error.localized(s, locale),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
        ),
        AppSpacings.s24.verticalSpace,
        AppTextFormField(
          key: keys.registerPage.lastNameField,
          leadingIcon: AppStandardIcons.user01,
          label: s.register_family_name_field,
          field: profileFormCubit.lastName,
          translateError: (error) => error.localized(s, locale),
          textCapitalization: TextCapitalization.words,
        ),
        AppSpacings.s24.verticalSpace,
        TermsConditionsCheckbox(
          key: keys.registerPage.termsCheckbox,
          checkboxBodyKey: keys.registerPage.termsCheckboxBody,
          field: profileFormCubit.checkbox,
        ),
        AppSpacings.s24.verticalSpace,
        if (generalError != null)
          Padding(
            padding: AppSpacings.s16.top + AppSpacings.s4.bottom,
            child: AppText(
              switch (generalError) {
                RegisterUnknownError() => s.register_unknown_error,
                RegisterKratosError(:final error) => error.localized(s, locale),
              },
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyDefault,
            ),
          ),
      ],
    );
  }
}

class _RegisterPasswordForm extends StatelessWidget {
  const _RegisterPasswordForm(this.state);

  final RegisterStatePasswordEnter state;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final registerCubit = context.read<RegisterCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          s.register_fts,
          style: AppTextStyles.headlineLarge,
          color: context.colors.foregroundDefaultPrimary,
        ),
        AppSpacings.s24.verticalSpace,
        const AppStepProgress(
          totalSteps: 2,
          currentStepIndex: 2,
          valueBuilder: null,
        ),
        AppSpacings.s24.verticalSpace,
        AppPasswordFormField(
          key: keys.registerPage.passwordField,
          leadingIcon: AppStandardIcons.lock01,
          label: s.password_field,
          field: context.read<RegisterCubit>().passwordFormCubit.password,
          translateError: (errors) => errors.first.localized(s, locale),
        ),
        AppSpacings.s24.verticalSpace,
        SizedBox(
          width: double.infinity,
          child: AppButton(
            key: keys.registerPage.setPasswordButton,
            caption: s.register_set_password,
            onTap: registerCubit.registerWithPassword,
            analyticsId: AnalyticsIds.recoveryEmailButton,
            type: AppButtonType.secondary,
          ),
        ),
        if (state.generalError case final generalError?)
          Padding(
            padding: AppSpacings.s16.top + AppSpacings.s4.bottom,
            child: AppText(
              switch (generalError) {
                RegisterUnknownError() => s.register_unknown_error,
                RegisterKratosError(:final error) => error.localized(s, locale),
              },
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyDefault,
            ),
          ),
      ],
    );
  }
}
