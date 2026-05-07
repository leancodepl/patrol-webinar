import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/features/auth/menu/passkey_management/passkey_management_cubit.dart';
import 'package:fts/features/connectivity/connectivity_app_top_bar.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/context_snackbar_padding_extension.dart';
import 'package:fts/widgets/widgets.dart';

class PasskeysPage extends StatelessWidget {
  const PasskeysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasskeyManagementCubit(
        kratosClient: context.read(),
        passkeyCredentialManager: context.read(),
      )..init(),
      child: _PasskeysContent(),
    );
  }
}

class _PasskeysContent extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useOnStreamChange(
      context.watch<PasskeyManagementCubit>().presentation,
      onData: (event) => _handlePasskeyManagementEvent(context, event),
    );

    final s = l10n(context);
    return AppScaffold(
      topBar: ConnectivityAppTopBar(
        centerTitle: false,
        title: s.settings_account_passkeys,
      ),
      useBodyPadding: false,
      body: BlocBuilder<PasskeyManagementCubit, PasskeyManagementState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const AppLoadingOverlay(isLoading: true);
          } else {
            return AppLoadingOverlay(
              isLoading: state.isUpdating,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: AppSpacings.s16.horizontal + AppSpacings.s16.top,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _PasskeyItem(
                            passkeyState: state,
                            index: index,
                          );
                        },
                        itemCount: state.passkeys.length,
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding:
                          AppSpacings.s16.horizontal + AppSpacings.s40.bottom,
                      child: SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          type: AppButtonType.primary,
                          caption: s.add_passkey_title,
                          onTap: () {
                            context.read<PasskeyManagementCubit>().addPasskey();
                          },
                          analyticsId: AnalyticsIds.addNewPasskeyButton,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _handlePasskeyManagementEvent(
    BuildContext context,
    PasskeyManagementEvent event,
  ) {
    final s = l10n(context);

    switch (event) {
      case PasskeyManagementEvent.reauthenticationRequired:
        const ReauthorizeRoute().push<void>(context);
      case PasskeyManagementEvent.additionSuccess:
        context.pushSnackbar(
          AppSnackbar(
            type: AppSnackbarType.success,
            text: s.add_passkey_success,
            padding: context.snackbarPadding,
          ),
        );
      case PasskeyManagementEvent.removalSuccess:
        context.pushSnackbar(
          AppSnackbar(
            type: AppSnackbarType.success,
            text: s.remove_passkey_success,
            padding: context.snackbarPadding,
          ),
        );
      case PasskeyManagementEvent.additionError:
        context.pushSnackbar(
          AppSnackbar(
            type: AppSnackbarType.danger,
            text: s.add_passkey_error,
            padding: context.snackbarPadding,
          ),
        );
      case PasskeyManagementEvent.removalError:
        context.pushSnackbar(
          AppSnackbar(
            type: AppSnackbarType.danger,
            text: s.remove_passkey_error,
            padding: context.snackbarPadding,
          ),
        );
    }
  }
}

class _PasskeyItem extends StatelessWidget {
  const _PasskeyItem({required this.passkeyState, required this.index});

  final PasskeyManagementState passkeyState;
  final int index;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return AppListItem(
      title: passkeyState.passkeys[index].displayName,
      trailingIcon: AppListItemIcon.icon(
        icon: AppStandardIcons.trash01,
        semanticsLabel: s.remove_passkey_title,
      ),
      onTap: () {
        context.read<PasskeyManagementCubit>().removePasskey(
          passkeyState.passkeys[index].id,
        );
      },
    );
  }
}
