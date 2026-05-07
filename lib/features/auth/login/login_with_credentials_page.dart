import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/auth/kratos/common/kratos_message_localized.dart';
import 'package:fts/features/auth/login/login_cubit.dart';
import 'package:fts/features/connectivity/connectivity_app_top_bar.dart';
import 'package:fts/keys.dart';
import 'package:fts/navigation/navigate_after_login.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/context_snackbar_padding_extension.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class LoginWithCredentialsPage extends StatelessWidget {
  const LoginWithCredentialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(kratosClient: context.read(), authCubit: context.read()),
      child: const _LoginWithCredentialsContent(),
    );
  }
}

class _LoginWithCredentialsContent extends HookWidget {
  const _LoginWithCredentialsContent();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    useOnStreamChange(
      context.watch<LoginCubit>().presentation,
      onData: (event) => switch (event) {
        LoginEventSuccess() => navigateAfterLogin(context),
        LoginEventVerifyEmail(:final email) => VerifyRoute(
          email: email,
        ).push<void>(context),
      },
    );

    final topBar = ConnectivityAppTopBar(
      title: s.login_header,
      leading: AppTopBarAction.icon(
        icon: AppStandardIcons.arrowLeft,
        semanticsLabel: s.common_back,
        onTap: () => const HomeRoute().go(context),
      ),
    );

    final loginCubit = context.read<LoginCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state case AuthStateUnauthorized(accountRemoved: true)) {
          context.pushSnackbar(
            AppSnackbar(
              text: s.delete_account_success,
              type: AppSnackbarType.success,
              padding: context.snackbarPadding,
            ),
          );
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        bloc: loginCubit,
        builder: (context, state) {
          return AppLoadingOverlay(
            isLoading: switch (state) {
              LoginStateInitial(:final inProgress) => inProgress,
              _ => false,
            },
            child: switch (state) {
              LoginStateInitial() => _LoginForm(
                topBar: topBar,
                initialState: state,
              ),
              LoginStateUnverified() => _LoginUnverifiedAccountMessage(
                topBar: topBar,
                state: state,
              ),
            },
          );
        },
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({required this.topBar, required this.initialState});

  final AppTopBar topBar;
  final LoginStateInitial initialState;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final loginCubit = context.read<LoginCubit>();

    return AppScaffold.widgets(
      topBar: topBar,
      footerBehavior: AppScaffoldFooterBehavior.bottomPinned,
      footerBuilder: (context, overlapsContent, padding) => Padding(
        padding: padding,
        child: AppButton(
          analyticsId: AnalyticsIds.loginRegisterButton,
          caption: s.login_signup_button,
          onTap: () => const RegisterRoute().push<void>(context),
          type: AppButtonType.tertiary,
        ),
      ),
      children: [
        AutofillGroup(
          child: Column(
            children: [
              AppTextFormField(
                key: keys.loginWithCredentialsPage.emailField,
                label: s.email_field,
                field: loginCubit.formCubit.email,
                translateError: (error) => error.localized(s, locale),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                autocorrect: false,
              ),
              AppSpacings.s16.verticalSpace,
              AppPasswordFormField(
                key: keys.loginWithCredentialsPage.passwordField,
                label: s.password_field,
                field: loginCubit.formCubit.password,
                autofillHints: const [AutofillHints.password],
                translateError: (errors) => errors.first.localized(s, locale),
                autocorrect: false,
              ),
            ],
          ),
        ),
        AppSpacings.s16.verticalSpace,
        AppButton(
          key: keys.loginWithCredentialsPage.loginButton,
          analyticsId: AnalyticsIds.loginButton,
          caption: s.login_button,
          onTap: loginCubit.login,
          type: AppButtonType.primary,
        ),
        AppSpacings.s16.verticalSpace,
        AppButton(
          analyticsId: AnalyticsIds.loginRecoveryButton,
          caption: s.login_page_recovery_button,
          onTap: () => const RecoveryRoute().push<void>(context),
          type: AppButtonType.tertiary,
        ),
        if (initialState.generalError case final generalError?)
          Padding(
            padding: AppSpacings.s16.top,
            child: AppText(
              switch (generalError) {
                LoginUnknownError() => s.login_unknown_error,
                LoginKratosError(:final error) => error.localized(s, locale),
              },
              style: AppTextStyles.bodyDefault,
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}

class _LoginUnverifiedAccountMessage extends StatelessWidget {
  const _LoginUnverifiedAccountMessage({
    required this.topBar,
    required this.state,
  });

  final AppTopBar topBar;
  final LoginStateUnverified state;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return AppScaffold.widgets(
      topBar: topBar,
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
        AppSpacings.s32.verticalSpace,
        AppButton(
          caption: s.login_verify_account_button,
          onTap: () => VerifyRoute(email: state.email).push<void>(context),
          analyticsId: AnalyticsIds.loginWithGoogleButton,
          type: AppButtonType.secondary,
        ),
      ],
    );
  }
}
