import 'package:flutter/material.dart' show Dialog;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/auth/menu/account_delete/account_delete_cubit.dart';
import 'package:fts/keys.dart';
import 'package:fts/navigation/pop_until.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/context_snackbar_padding_extension.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountDeleteCubit(cqrs: context.read()),
      child: const _DeleteAccountDialog(),
    );
  }
}

class _DeleteAccountDialog extends HookWidget {
  const _DeleteAccountDialog();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final colors = context.colors;

    final deleteAccountCubit = context.watch<AccountDeleteCubit>();

    useOnStreamChange(
      deleteAccountCubit.presentation,
      onData: (event) {
        switch (event) {
          case AccountDeleteEvent.success:
            context.read<AuthCubit>().logout(accountRemoved: true);
            // Pop until we are back on the settings page
            context.popUntil(
              (state) =>
                  state.fullPath == null ||
                  state.fullPath == const SettingsRoute().location,
            );
          case AccountDeleteEvent.error:
            context.pop();
            context.pushSnackbar(
              AppSnackbar(
                type: AppSnackbarType.danger,
                text: l10n(context).delete_account_error,
                padding: context.snackbarPadding,
              ),
            );
        }
      },
    );

    return AppLoadingOverlay(
      isLoading: deleteAccountCubit.state == AccountDeleteState.inProgress,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.all(16),
        elevation: 0,
        child: Padding(
          padding: AppSpacings.s24.all,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText(
                s.delete_account_title,
                style: AppTextStyles.headlineMedium,
                textAlign: TextAlign.center,
              ),
              AppSpacings.s8.verticalSpace,
              AppText(
                s.delete_account_subtitle,
                style: AppTextStyles.bodyDefault,
                color: colors.foregroundDefaultSecondary,
                textAlign: TextAlign.center,
              ),
              AppSpacings.s16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      onTap: context.pop,
                      caption: s.delete_account_cancelButton,
                      analyticsId: AnalyticsIds.cancelDialogButton,
                      type: AppButtonType.secondary,
                    ),
                  ),
                  AppSpacings.s8.horizontalSpace,
                  Expanded(
                    child: AppButton(
                      key: keys.menu.deleteAccountConfirmButton,
                      onTap: deleteAccountCubit.deleteAccount,
                      caption: s.delete_account_confirmButton,
                      analyticsId: AnalyticsIds.menuDeleteAccount,
                      type: AppButtonType.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
