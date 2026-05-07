import 'package:flutter/material.dart' show CircleAvatar, ListTile, showDialog;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/util/profile_traits_extension.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/auth/menu/menu_cubit.dart';
import 'package:fts/features/auth/menu/passkey_management/passkey_management_cubit.dart';
import 'package:fts/features/auth/menu/widgets/delete_account_dialog.dart';
import 'package:fts/features/auth/passkey/common/widgets/passkey_availability_guard.dart';
import 'package:fts/features/connectivity/connectivity_app_top_bar.dart';
import 'package:fts/keys.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/context_snackbar_padding_extension.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_app_rating/leancode_app_rating.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MenuCubit(
            userRepository: context.read(),
            flutterSecureCredentialsStorage: context.read(),
          )..init(),
        ),
        BlocProvider(
          create: (context) => PasskeyManagementCubit(
            kratosClient: context.read(),
            passkeyCredentialManager: context.read(),
          )..init(),
        ),
      ],
      child: const _MenuContent(),
    );
  }
}

class _MenuContent extends HookWidget {
  const _MenuContent();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    useOnStreamChange(
      context.watch<PasskeyManagementCubit>().presentation,
      onData: (event) => _handlePasskeyManagementEvent(context, event),
    );

    return AppScaffold(
      topBar: ConnectivityAppTopBar(
        leading: AppTopBarAction.icon(
          icon: AppStandardIcons.xClose,
          semanticsLabel: s.common_close,
          onTap: () => const HomeRoute().go(context),
        ),
      ),
      useBodyPadding: false,
      body: Builder(
        builder: (context) {
          final menuState = context.watch<MenuCubit>().state;
          final passkeyState = context.watch<PasskeyManagementCubit>().state;

          if (passkeyState.isLoading || menuState is! MenuStateLoaded) {
            return const Center(child: AppLoadingOverlay(isLoading: true));
          }

          return _MenuBody(menuState: menuState, passkeyState: passkeyState);
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
        const ReauthorizeRoute().go(context);
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

class _MenuBody extends StatelessWidget {
  const _MenuBody({required this.menuState, required this.passkeyState});

  final MenuStateLoaded menuState;
  final PasskeyManagementState passkeyState;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: AppText(
            menuState.traits.email ?? '',
            style: AppTextStyles.bodyDefault,
          ),
          subtitle: AppText(
            '${menuState.traits.givenName} ${menuState.traits.familyName}',
            style: AppTextStyles.subtitle,
          ),
          leading: CircleAvatar(
            backgroundColor: colors.backgroundInfoPrimary,
            child: AppText(
              menuState.traits.initials,
              style: AppTextStyles.captionDefault,
              textAlign: TextAlign.center,
              color: colors.backgroundDefaultPrimary,
            ),
          ),
        ),
        const AppDivider.vertical(),
        AppListItem(
          title: s.profile_my_profile,
          leadingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.userCircle,
            semanticsLabel: s.profile_my_profile,
          ),
        ),
        const AppDivider.vertical(),
        const Spacer(),
        const AppDivider.vertical(),
        AppListItem(
          title: s.delete_account_title,
          leadingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.trash01,
            semanticsLabel: s.delete_account_title,
          ),
          onTap: () => showDialog<void>(
            context: context,
            builder: (context) => const DeleteAccountDialog(),
          ),
        ),
        PasskeyAvailabilityGuard(
          child: Column(
            children: [
              const AppDivider.vertical(),
              _PasskeyItem(passkeyState: passkeyState),
            ],
          ),
        ),
        const AppDivider.vertical(),
        AppListItem(
          title: s.profile_password_change,
          leadingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.passcodeLock,
            semanticsLabel: s.profile_password_change,
          ),
          onTap: () => const ChangePasswordRoute().go(context),
        ),
        const AppDivider.vertical(),
        // TODO: This does not seem to work
        AppListItem(
          title: s.profile_rate_us,
          leadingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.star01,
            semanticsLabel: s.profile_rate_us,
          ),
          onTap: () => context.read<AppRating>().showStarDialog(context),
        ),
        const AppDivider.vertical(),
        AppListItem(
          key: keys.menu.logoutItem,
          title: s.profile_logout,
          leadingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.logOut01,
            semanticsLabel: s.profile_logout,
          ),
          onTap: context.read<AuthCubit>().logout,
        ),
      ],
    );
  }
}

class _PasskeyItem extends StatelessWidget {
  const _PasskeyItem({required this.passkeyState});

  final PasskeyManagementState passkeyState;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    final hasPasskey = passkeyState.passkeys.isNotEmpty;

    return AppListItem(
      title: hasPasskey ? s.remove_passkey_title : s.add_passkey_title,
      leadingIcon: AppListItemIcon.icon(
        icon: AppStandardIcons.key01,
        semanticsLabel: hasPasskey
            ? s.remove_passkey_title
            : s.add_passkey_title,
      ),
      onTap: () {
        hasPasskey
            // only one passkey is supported at the moment
            ? context.read<PasskeyManagementCubit>().removePasskey(
                passkeyState.passkeys.first.id,
              )
            : context.read<PasskeyManagementCubit>().addPasskey();
      },
    );
  }
}
