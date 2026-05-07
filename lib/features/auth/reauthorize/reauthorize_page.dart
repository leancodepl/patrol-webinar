import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/features/auth/kratos/common/kratos_message_localized.dart';
import 'package:fts/features/auth/reauthorize/reauthorize_cubit.dart';
import 'package:fts/features/auth/social/social_cubit.dart';
import 'package:fts/features/connectivity/connectivity_app_top_bar.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class ReauthorizePage extends StatelessWidget {
  const ReauthorizePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReauthorizeCubit(
            kratosClient: context.read(),
            userRepository: context.read(),
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
      child: const _ReauthorizeContent(),
    );
  }
}

class _ReauthorizeContent extends HookWidget {
  const _ReauthorizeContent();

  @override
  Widget build(BuildContext context) {
    useOnStreamChange(
      context.watch<SocialCubit>().presentation,
      onData: (event) {
        if (event case SocialEventSuccess()) {
          context.pop(true);
        }
      },
    );

    useOnStreamChange(
      context.watch<ReauthorizeCubit>().presentation,
      onData: (event) {
        switch (event) {
          case ReauthorizeEvent.success:
            context.pop(true);
        }
      },
    );

    return AppScaffold(
      topBar: ConnectivityAppTopBar(title: l10n(context).reauthorize_title),
      body: const _ReauthorizeBody(),
    );
  }
}

class _ReauthorizeBody extends HookWidget {
  const _ReauthorizeBody();

  @override
  Widget build(BuildContext context) {
    final showInfo = useState<bool>(true);

    return switch (showInfo.value) {
      true => _InfoScreen(showInfo: showInfo),
      false => const _ReauthorizeForm(),
    };
  }
}

class _InfoScreen extends StatelessWidget {
  const _InfoScreen({required this.showInfo});

  final ValueNotifier<bool> showInfo;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          s.reauthorize_info,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyDefault,
        ),
        AppSpacings.s32.verticalSpace,
        AppButton(
          analyticsId: AnalyticsIds.reauthorizeNextButton,
          caption: s.reauthorize_info_button,
          onTap: () {
            showInfo.value = false;
          },
          type: AppButtonType.primary,
        ),
      ],
    );
  }
}

class _ReauthorizeForm extends StatelessWidget {
  const _ReauthorizeForm();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final reauthorizeCubit = context.watch<ReauthorizeCubit>();

    final generalError = reauthorizeCubit.state.generalError;

    final inProgress = context.select<SocialCubit, bool>(
      (cubit) => cubit.state.inProgress,
    );

    return PopScope(
      canPop: false,
      child: AppLoadingOverlay(
        isLoading: inProgress,
        child: Column(
          children: [
            AppButton(
              analyticsId: AnalyticsIds.loginWithAppleButton,
              caption: s.login_with_apple_button,
              onTap: () => context.read<SocialCubit>().registerWithOidc(
                OidcProvider.apple,
              ),
              type: AppButtonType.primary,
            ),
            AppSpacings.s16.verticalSpace,
            AppButton(
              analyticsId: AnalyticsIds.loginWithGoogleButton,
              caption: s.login_with_google_button,
              onTap: () => context.read<SocialCubit>().registerWithOidc(
                OidcProvider.google,
              ),
              type: AppButtonType.primary,
            ),
            AppSpacings.s16.verticalSpace,
            AppPasswordFormField(
              field: reauthorizeCubit.formCubit.password,
              translateError: (errors) => errors.first.localized(s, locale),
              label: s.password_field,
              autocorrect: false,
            ),
            AppSpacings.s16.verticalSpace,
            AppButton(
              analyticsId: AnalyticsIds.loginButton,
              caption: s.login_button,
              onTap: reauthorizeCubit.reauthorizeWithPassword,
              type: AppButtonType.primary,
            ),
            AppSpacings.s16.verticalSpace,
            if (generalError != null)
              Padding(
                padding: AppSpacings.s16.top + AppSpacings.s4.bottom,
                child: AppText(
                  switch (generalError) {
                    LoginUnknownError() => s.register_unknown_error,
                    LoginKratosError(:final error) => error.localized(
                      s,
                      locale,
                    ),
                  },
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyDefault,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
