import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/util/profile_traits_extension.dart';
import 'package:fts/features/auth/menu/menu_cubit.dart';
import 'package:fts/features/auth/menu/widgets/delete_account_dialog.dart';
import 'package:fts/features/error_page/error_page.dart';
import 'package:fts/keys.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/assets.gen.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuCubit(
        userRepository: context.read(),
        flutterSecureCredentialsStorage: context.read(),
      )..init(),
      child: _AccountContent(),
    );
  }
}

class _AccountContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    return AppScaffold(
      topBar: AppTopBar(title: s.settings_account, centerTitle: false),
      body: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) => switch (state) {
          MenuStateLoading() => const Center(
            child: AppLoadingOverlay(isLoading: true),
          ),
          MenuStateLoaded() => _LoadedAccount(menuState: state),
          MenuStateUnauthenticated() => throw StateError('Unauthenticated'),
          MenuStateError() => ErrorPage(
            onTryAgain: context.read<MenuCubit>().refresh,
          ),
        },
      ),
    );
  }
}

class _LoadedAccount extends StatelessWidget {
  const _LoadedAccount({required this.menuState});

  final MenuStateLoaded menuState;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    return ListView(
      children: [
        AppListItem(
          title: '${menuState.traits.givenName} ${menuState.traits.familyName}',
          subtitle: menuState.traits.email,
          leadingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.userCircle,
            semanticsLabel: s.profile_my_profile,
          ),
        ),
        const AppListDivider(),
        AppSpacings.s24.verticalSpace,
        AppText(
          s.settings_account_security,
          style: AppTextStyles.captionDefault,
        ),
        AppSpacings.s4.verticalSpace,
        const AppListDivider(),
        AppListItem(
          title: s.settings_account_passkeys,
          leadingIcon: AppListItemIcon.widget(
            child: Assets.social.passkeyIconStrokes.svg(width: 24, height: 24),
          ),
          trailingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.chevronRight,
            semanticsLabel: s.settings_account_passkeys,
          ),
          onTap: () => const PasskeysRoute().push<void>(context),
        ),
        const AppListDivider(),
        AppListItem(
          title: s.settings_account_changePassword,
          leadingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.passcode,
            semanticsLabel: s.settings_account_changePassword,
          ),
          trailingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.chevronRight,
            semanticsLabel: s.settings_account_changePassword,
          ),
          onTap: () => const ChangePasswordRoute().push<void>(context),
        ),
        const AppListDivider(),
        AppListItem(
          key: keys.menu.deleteAccountItem,
          title: s.settings_account_delete,
          leadingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.trash01,
            semanticsLabel: s.settings_account_delete,
          ),
          trailingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.chevronRight,
            semanticsLabel: s.settings_account_delete,
          ),
          onTap: () => showDialog<void>(
            context: context,
            builder: (context) => const DeleteAccountDialog(),
          ),
        ),
        const AppListDivider(),
      ],
    );
  }
}
