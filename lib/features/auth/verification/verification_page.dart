import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/common/keys/page_ids.dart';
import 'package:fts/features/auth/common/resend_button.dart';
import 'package:fts/features/auth/common/resend_button_cubit.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/auth/verification/expired_flow_form_cubit.dart';
import 'package:fts/features/auth/verification/verification_cubit.dart';
import 'package:fts/features/connectivity/connectivity_app_top_bar.dart';
import 'package:fts/keys.dart';
import 'package:fts/navigation/navigate_after_login.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/context_snackbar_padding_extension.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

const verificationCodeLength = 6;

class VerificationPage extends StatelessWidget {
  const VerificationPage({
    super.key,
    required this.email,
    required this.flowId,
    required this.code,
  });

  final String? email;
  final String? flowId;
  final String? code;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VerificationCubit(
            initialFlowId: flowId,
            email: email,
            kratosClient: context.read(),
          )..init(),
        ),
        BlocProvider(create: (context) => ResendButtonCubit()..init()),
      ],
      child: _VerificationContent(code: code),
    );
  }
}

class _VerificationContent extends HookWidget {
  const _VerificationContent({required this.code});

  final String? code;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final pinController = useTextEditingController(text: code);

    useOnStreamChange(
      context.watch<VerificationCubit>().presentation,
      onData: (event) => _verificationEventListener(
        context: context,
        event: event,
        pinController: pinController,
      ),
    );

    return AppScaffold(
      topBar: ConnectivityAppTopBar(
        title: s.verification_page_title,
        leading: AppTopBarAction.icon(
          icon: AppStandardIcons.arrowLeft,
          semanticsLabel: s.common_back,
          onTap: context.pop,
        ),
      ),
      body: _VerificationBody(pinController: pinController),
    );
  }

  void _verificationEventListener({
    required BuildContext context,
    required VerificationEvent event,
    required TextEditingController pinController,
  }) {
    final isAuthorized = context.read<AuthCubit>().state is AuthStateLoggedIn;
    final s = l10n(context);

    switch (event) {
      case VerificationEvent.successSend:
        context.pushSnackbar(
          AppSnackbar(
            type: AppSnackbarType.success,
            text: s.verification_code_send_success,
            padding: context.snackbarPadding,
          ),
        );

      case VerificationEvent.errorSend:
        context.pushSnackbar(
          AppSnackbar(
            type: AppSnackbarType.danger,
            text: s.verification_code_send_error,
            padding: context.snackbarPadding,
          ),
        );

      case VerificationEvent.successVerification:
        context.pushSnackbar(
          AppSnackbar(
            type: AppSnackbarType.success,
            text: s.success_verification,
            padding: context.snackbarPadding,
          ),
        );

        if (isAuthorized) {
          navigateAfterLogin(context);
        } else {
          const LoginRoute().pushReplacement(context);
        }

      case VerificationEvent.errorVerification:
        context.pushSnackbar(
          AppSnackbar(
            type: AppSnackbarType.danger,
            text: s.error_verification,
            padding: context.snackbarPadding,
          ),
        );

        pinController.clear();
    }
  }
}

class _VerificationBody extends StatelessWidget {
  const _VerificationBody({required this.pinController});

  final TextEditingController pinController;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final verificationCubit = context.watch<VerificationCubit>();
    final state = verificationCubit.state;

    return Padding(
      padding: AppSpacings.s16.all,
      child: AppLoadingOverlay(
        isLoading: state.inProgress,
        child: switch (state) {
          VerificationStateExpired() => const _ExpiredFlow(),
          VerificationStateLoading() => const SizedBox(),
          VerificationStateInitError() => AppErrorView(
            pageId: PageId.verify,
            onRetry: state.retriable ? verificationCubit.init : null,
          ),
          VerificationStateReady() || VerificationStateInProgress() => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSpacings.s32.verticalSpace,
              AppText(
                s.verification_page_header,
                color: context.colors.foregroundDefaultPrimary,
                style: AppTextStyles.headlineSmall,
              ),
              AppSpacings.s8.verticalSpace,
              AppText(
                s.verification_page_subtitle,
                style: AppTextStyles.bodyDefault,
              ),
              AppSpacings.s24.verticalSpace,
              AppTextFormField(
                key: keys.verificationPage.codeField,
                label: s.verification_page_field,
                field: verificationCubit.code,
                translateError: (error) => error.localized(s, locale),
                textInputAction: TextInputAction.next,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
              ),
              ResendButton(
                onTap: () {
                  verificationCubit.getNewVerificationFlow();
                  context.read<ResendButtonCubit>().markSendAction();
                },
                analyticsId: AnalyticsIds.loginVerifyResendButton,
              ),
              AppButton(
                key: keys.verificationPage.continueButton,
                onTap: () => verificationCubit.verify(
                  code: verificationCubit.code.state.value,
                ),
                caption: s.verification_page_button,
                analyticsId: AnalyticsIds.verifyResendOTP,
                type: AppButtonType.primary,
              ),
            ],
          ),
        },
      ),
    );
  }
}

class _ExpiredFlow extends StatelessWidget {
  const _ExpiredFlow();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpiredFlowFormCubit(),
      child: const _ExpiredFlowContent(),
    );
  }
}

class _ExpiredFlowContent extends StatelessWidget {
  const _ExpiredFlowContent();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final formCubit = context.watch<ExpiredFlowFormCubit>();

    return Padding(
      padding: AppSpacings.s16.all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(s.verify_expired_header, style: AppTextStyles.headlineMedium),
          AppSpacings.s16.verticalSpace,
          AppText(s.verify_expired_subtitle, style: AppTextStyles.bodyDefault),
          AppSpacings.s32.verticalSpace,
          AppTextFormField(
            field: formCubit.email,
            translateError: (error) => error.localized(s, locale),
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            hint: s.email_field,
          ),
          AppSpacings.s32.verticalSpace,
          AppButton(
            caption: s.verify_expired_button,
            onTap: () {
              if (!formCubit.validate()) {
                return;
              }
              VerifyRoute(
                email: formCubit.email.state.value,
              ).pushReplacement(context);
            },
            analyticsId: AnalyticsIds.verifyResendFlow,
            type: AppButtonType.primary,
          ),
        ],
      ),
    );
  }
}
