import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/common/util/app_platform.dart';
import 'package:fts/common/util/spaced.dart';
import 'package:fts/features/auth/common/caption_divider.dart';
import 'package:fts/features/auth/common/small_social_button.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/auth/kratos/common/kratos_message_localized.dart';
import 'package:fts/features/auth/login/login_cubit.dart';
import 'package:fts/features/auth/passkey/passkey_login/passkey_login_cubit.dart';
import 'package:fts/features/auth/social/social_cubit.dart';
import 'package:fts/features/auth/social/social_traits_form.dart';
import 'package:fts/features/connectivity/connectivity_app_top_bar.dart';
import 'package:fts/features/connectivity/connectivity_banner.dart';
import 'package:fts/keys.dart';
import 'package:fts/navigation/navigate_after_login.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/context_snackbar_padding_extension.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(
            kratosClient: context.read(),
            authCubit: context.read(),
          ),
        ),
        BlocProvider(
          create: (context) => SocialCubit(
            appLifecycleProvider: context.read(),
            kratosClient: context.read(),
            authCubit: context.read(),
          )..init(),
        ),
        BlocProvider(
          create: (context) => PasskeyLoginCubit(
            kratosClient: context.read(),
            authCubit: context.read(),
            passkeyCredentialManager: context.read(),
          ),
        ),
      ],
      child: const _LoginContent(),
    );
  }
}

class _LoginContent extends HookWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    void navigateToEmailVerification({String? email, String? flowId}) =>
        VerifyRoute(email: email, flowId: flowId).push<void>(context);

    useOnStreamChange(
      context.watch<LoginCubit>().presentation,
      onData: (event) => switch (event) {
        LoginEventSuccess() => navigateAfterLogin(context),
        LoginEventVerifyEmail(:final email) => navigateToEmailVerification(
          email: email,
        ),
      },
    );

    useOnStreamChange(
      context.watch<SocialCubit>().presentation,
      onData: (event) => switch (event) {
        SocialEventSuccess() => navigateAfterLogin(context),
        SocialEventVerifyEmail(:final email, :final flowId) =>
          navigateToEmailVerification(email: email, flowId: flowId),
        SocialEventAccountExists() => context.pushSnackbar(
          AppSnackbar(
            type: AppSnackbarType.warning,
            text: s.login_login_method_not_added_to_account_message,
            padding: context.snackbarPadding,
          ),
        ),
      },
    );

    useOnStreamChange(
      context.watch<PasskeyLoginCubit>().presentation,
      onData: (event) => switch (event) {
        PasskeyLoginEventSuccess() => navigateAfterLogin(context),
        PasskeyLoginEventVerifyEmail() => navigateToEmailVerification(
          flowId: event.flowId,
        ),
        PasskeyLoginEventNoCredentialsAvailable() => context.pushSnackbar(
          AppSnackbar(
            type: AppSnackbarType.warning,
            text: s.passkey_login_no_credentials_available_error,
            padding: context.snackbarPadding,
          ),
        ),
        PasskeyLoginEventError() => context.pushSnackbar(
          AppSnackbar(
            type: AppSnackbarType.warning,
            text: event.message?.localized(s, locale) ?? s.login_unknown_error,
            padding: context.snackbarPadding,
          ),
        ),
      },
    );

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state case AuthStateUnauthorized(accountRemoved: true)) {
          context.pushSnackbar(
            AppSnackbar(
              type: AppSnackbarType.success,
              text: s.delete_account_success,
              padding: context.snackbarPadding,
            ),
          );
        }
      },
      child: BlocBuilder<SocialCubit, SocialState>(
        builder: (context, socialState) => switch (socialState) {
          SocialStateTraitsStep() => const _SocialTraitsForm(),
          SocialStateIdle() => BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) => AppLoadingOverlay(
              isLoading: switch (state) {
                LoginStateInitial(:final inProgress) => inProgress,
                _ => socialState.inProgress,
              },
              child: switch (state) {
                LoginStateInitial() => _LoginForm(initialState: state),
                LoginStateUnverified() => _LoginUnverifiedAccountMessage(
                  state: state,
                ),
              },
            ),
          ),
        },
      ),
    );
  }
}

class _SocialTraitsForm extends StatelessWidget {
  const _SocialTraitsForm();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(useBodyPadding: false, body: const SocialTraitsForm());
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({required this.initialState});

  final LoginStateInitial initialState;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    return AppScaffold(
      topBar: const AppTopBar(divider: false),
      useBodyPadding: false,
      body: Column(
        children: [
          const ConnectivityBanner(),
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacings.s24.horizontal + AppSpacings.s40.vertical,
              child: Column(
                spacing: 24,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    s.loginPage_title,
                    style: AppTextStyles.headlineLarge,
                    color: context.colors.foregroundDefaultPrimary,
                  ),
                  const _CredentialsLoginForm(),
                  CaptionDivider(caption: s.login_social_caption),
                  const _SocialButtons(),
                  if (initialState.generalError case final generalError?)
                    AppText(
                      switch (generalError) {
                        LoginUnknownError() => s.login_unknown_error,
                        LoginKratosError(:final error) => error.localized(
                          s,
                          locale,
                        ),
                        SocialUnknownError() => s.login_unknown_error,
                        SocialKratosGeneralError(:final error) =>
                          error.localized(s, locale),
                      },
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyDefault,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginUnverifiedAccountMessage extends StatelessWidget {
  const _LoginUnverifiedAccountMessage({required this.state});

  final LoginStateUnverified state;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return AppScaffold.widgets(
      topBar: ConnectivityAppTopBar(title: s.login_header),
      children: [
        AppText(
          s.login_verify_account_header,
          style: AppTextStyles.headlineMedium,
        ),
        AppSpacings.s8.verticalSpace,
        AppText(
          s.login_verify_account_subtitle,
          style: AppTextStyles.bodyDefault,
        ),
        const SizedBox(height: 32),
        AppButton(
          analyticsId: AnalyticsIds.loginWithGoogleButton,
          type: AppButtonType.secondary,
          caption: s.login_verify_account_button,
          onTap: () => VerifyRoute(email: state.email).push<void>(context),
        ),
      ],
    );
  }
}

class _CredentialsLoginForm extends StatelessWidget {
  const _CredentialsLoginForm();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final loginCubit = context.read<LoginCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutofillGroup(
          child: Column(
            children: [
              AppTextFormField(
                key: keys.loginPage.emailField,
                label: s.email_field,
                leadingIcon: AppStandardIcons.mail01,
                field: loginCubit.formCubit.email,
                translateError: (error) => error.localized(s, locale),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                autocorrect: false,
              ),
              AppSpacings.s16.verticalSpace,
              AppPasswordFormField(
                key: keys.loginPage.passwordField,
                label: s.password_field,
                leadingIcon: AppStandardIcons.lock01,
                field: loginCubit.formCubit.password,
                autofillHints: const [AutofillHints.password],
                translateError: (errors) => errors.first.localized(s, locale),
                autocorrect: false,
              ),
            ],
          ),
        ),
        AppSpacings.s16.verticalSpace,
        AppTextButton(
          analyticsId: AnalyticsIds.loginRecoveryButton,
          caption: s.forgot_password_button,
          onTap: () => const RecoveryRoute().push<void>(context),
          type: AppTextButtonType.base,
        ),
        AppSpacings.s24.verticalSpace,
        SizedBox(
          width: double.infinity,
          child: AppButton(
            key: keys.loginPage.loginButton,
            analyticsId: AnalyticsIds.loginButton,
            caption: s.login_button,
            onTap: loginCubit.login,
            type: AppButtonType.primary,
          ),
        ),
      ],
    );
  }
}

class _SocialButtons extends StatelessWidget {
  const _SocialButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (AppPlatform.platform.isAndroid)
          SmallGoogleButton(
            onTap: () => context.read<SocialCubit>().registerWithOidc(
              OidcProvider.google,
            ),
            analyticsId: AnalyticsIds.loginWithGoogleButton,
          ),
        if (AppPlatform.platform.isIos)
          SmallAppleButton(
            onTap: () => context.read<SocialCubit>().registerWithOidc(
              OidcProvider.apple,
            ),
            analyticsId: AnalyticsIds.loginWithAppleButton,
          ),
        SmallPasskeyButton(
          onTap: () => context.read<PasskeyLoginCubit>().login(),
          analyticsId: AnalyticsIds.loginWithPasskeyButton,
        ),
      ].spaced(AppSpacings.s24, Axis.horizontal),
    );
  }
}
