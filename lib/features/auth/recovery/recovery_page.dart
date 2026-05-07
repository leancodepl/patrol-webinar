import 'package:app_design_system/app_design_system.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/features/auth/common/resend_button.dart';
import 'package:fts/features/auth/common/resend_button_cubit.dart';
import 'package:fts/features/auth/recovery/recovery_cubit.dart';
import 'package:fts/features/connectivity/connectivity_banner.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/context_snackbar_padding_extension.dart';
import 'package:fts/widgets/widgets.dart';

class RecoveryPage extends StatelessWidget {
  const RecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              RecoveryCubit(kratosClient: context.read())..getRecoveryFlow(),
        ),
        BlocProvider(create: (context) => ResendButtonCubit()..init()),
      ],
      child: const _RecoveryContent(),
    );
  }
}

class _RecoveryContent extends StatelessWidget {
  const _RecoveryContent();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return BlocPresentationListener<RecoveryCubit, RecoveryEvent>(
      listener: (context, event) {
        switch (event) {
          case RecoveryEvent.success:
            context.pushSnackbar(
              AppSnackbar(
                type: AppSnackbarType.success,
                text: s.recovery_page_password_changed,
                padding: context.snackbarPadding,
              ),
            );

            const LoginRoute().pushReplacement(context);
          case RecoveryEvent.error:
            context.pushSnackbar(
              AppSnackbar(
                type: AppSnackbarType.danger,
                text: s.kratos_error_system_generic,
                padding: context.snackbarPadding,
              ),
            );

            const LoginRoute().pushReplacement(context);
        }
      },
      child: AppScaffold(
        topBar: const AppTopBar(divider: false),
        useBodyPadding: false,
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: ConnectivityBanner()),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: AppSpacings.s32.horizontal,
                child: BlocBuilder<RecoveryCubit, RecoveryState>(
                  builder: (context, state) => switch (state) {
                    RecoveryStateEmailEntry() =>
                      const _RecoveryEnterEmailWidget(),
                    RecoveryStatePinEntry() => _RecoveryEnterPinWidget(
                      state: state,
                    ),
                    RecoveryStateFlowPinResult() => _KratosNewPasswordView(
                      state: state,
                    ),
                    RecoveryStateInitial() ||
                    RecoveryStateLoading() ||
                    RecoveryStateSuccess() ||
                    RecoveryStateFlowError() => const Center(
                      child: AppLoadingOverlay(isLoading: true),
                    ),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecoveryEnterPinWidget extends StatelessWidget {
  const _RecoveryEnterPinWidget({required this.state});

  final RecoveryStatePinEntry state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_PinRecoverForm(), _PinRecoveryButtons()],
    );
  }
}

class _PinRecoverForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final recoveryCubit = context.watch<RecoveryCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          s.recovery_page_recover_headline,
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
        AppText(
          s.recovery_page_enter_code,
          style: AppTextStyles.bodyDefault,
          color: context.colors.foregroundDefaultSecondary,
        ),
        AppSpacings.s24.verticalSpace,
        AppTextFormField(
          label: s.recovery_page_code_label,
          field: recoveryCubit.code,
          translateError: (error) => error.localized(s, locale),
          textInputAction: TextInputAction.next,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          leadingIcon: AppStandardIcons.hash02,
        ),
        ResendButton(
          onTap: () {
            context.read<RecoveryCubit>().resendCode();
            context.read<ResendButtonCubit>().markSendAction();
          },
          analyticsId: AnalyticsIds.recoveryVerifyResendButton,
        ),
      ],
    );
  }
}

class _PinRecoveryButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          onTap: () => context.read<RecoveryCubit>().submitCode(),
          caption: s.verification_page_button,
          analyticsId: AnalyticsIds.verifyResendOTP,
          type: AppButtonType.primary,
        ),
        AppSpacings.s40.verticalSpace,
      ],
    );
  }
}

class _RecoveryEnterEmailWidget extends StatelessWidget {
  const _RecoveryEnterEmailWidget();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final recoveryCubit = context.watch<RecoveryCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _EmailRecoverForm(),
        Padding(
          padding: AppSpacings.s40.bottom,
          child: SizedBox(
            width: double.infinity,
            child: AppButton(
              caption: s.recovery_page_recover,
              onTap: recoveryCubit.sendEmail,
              analyticsId: AnalyticsIds.recoveryEmailButton,
              type: AppButtonType.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmailRecoverForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final recoveryCubit = context.watch<RecoveryCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          s.recovery_page_recover_headline,
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
        AppText(
          s.recovery_page_enter_email,
          style: AppTextStyles.bodyDefault,
          color: context.colors.foregroundDefaultSecondary,
        ),
        AppSpacings.s24.verticalSpace,
        AppTextFormField(
          field: recoveryCubit.recoveryEmailFormCubit.email,
          translateError: (error) => error.localized(s, locale),
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          leadingIcon: AppStandardIcons.mail01,
          label: s.email_field,
        ),
      ],
    );
  }
}

class _KratosNewPasswordView extends StatelessWidget {
  const _KratosNewPasswordView({required this.state});

  final RecoveryStateFlowPinResult state;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final recoveryCubit = context.watch<RecoveryCubit>();

    final formCubit = recoveryCubit.recoveryNewPasswordFormCubit;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppPasswordFormField(
          field: formCubit.password,
          translateError: (errors) => errors.first.localized(s, locale),
          textInputAction: TextInputAction.next,
          autocorrect: false,
          leadingIcon: AppStandardIcons.lock01,
          label: s.password_field,
        ),
        Padding(
          padding: AppSpacings.s24.bottom,
          child: AppButton(
            caption: s.recovery_page_send,
            onTap: recoveryCubit.setNewPassword,
            analyticsId: AnalyticsIds.recoveryEmailButton,
            type: AppButtonType.primary,
          ),
        ),
      ],
    );
  }
}
