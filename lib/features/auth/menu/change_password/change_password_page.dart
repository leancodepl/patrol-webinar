import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/features/auth/kratos/common/kratos_message_localized.dart';
import 'package:fts/features/auth/menu/change_password/change_password_cubit.dart';
import 'package:fts/features/connectivity/connectivity_app_top_bar.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/context_snackbar_padding_extension.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (context) => ChangePasswordCubit(kratosClient: context.read()),
      child: const _ChangePasswordContent(),
    );
  }
}

class _ChangePasswordContent extends StatelessWidget {
  const _ChangePasswordContent();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return AppScaffold(
      topBar: ConnectivityAppTopBar(
        title: s.settings_account_changePassword,
        centerTitle: false,
      ),
      body: const _ChangePasswordForm(),
    );
  }
}

class _ChangePasswordForm extends HookWidget {
  const _ChangePasswordForm();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final cubit = context.watch<ChangePasswordCubit>();

    final formCubit = cubit.formCubit;

    useOnStreamChange(
      cubit.presentation,
      onData: (event) async {
        switch (event) {
          case ChangePasswordEventSuccess():
            unawaited(
              context.pushSnackbar(
                AppSnackbar(
                  type: AppSnackbarType.success,
                  text: s.recovery_page_password_changed,
                  padding: context.snackbarPadding,
                ),
              ),
            );
            context.pop();
          case ChangePasswordEventError():
            unawaited(
              context.pushSnackbar(
                AppSnackbar(
                  type: AppSnackbarType.danger,
                  text:
                      event.kratosError?.localized(s, locale) ??
                      s.kratos_error_system_generic,
                  padding: context.snackbarPadding,
                ),
              ),
            );
            formCubit.resetAll();
          case ChangePasswordEventAuthorizationNeeded():
            final result = await const ReauthorizeRoute().push<bool>(context);
            if (result ?? false) {
              unawaited(cubit.submit());
            }
        }
      },
    );

    return AppLoadingOverlay(
      isLoading: cubit.state == ChangePasswordState.loading,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppPasswordFormField(
            field: formCubit.password,
            translateError: (errors) => errors.first.localized(s, locale),
            textInputAction: TextInputAction.next,
            autocorrect: false,
            leadingIcon: AppStandardIcons.lock01,
            label: s.settings_changePassword_new,
          ),
          Padding(
            padding: AppSpacings.s24.bottom,
            child: AppButton(
              onTap: cubit.submit,
              analyticsId: AnalyticsIds.changePasswordButton,
              caption: s.settings_changePassword_change,
              type: AppButtonType.primary,
            ),
          ),
        ],
      ),
    );
  }
}
