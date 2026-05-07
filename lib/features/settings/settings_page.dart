import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/common/util/profile_traits_extension.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/auth/menu/menu_cubit.dart';
import 'package:fts/features/connectivity/connectivity_app_top_bar.dart';
import 'package:fts/features/error_page/error_page.dart';
import 'package:fts/features/settings/document_page.dart';
import 'package:fts/keys.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuCubit(
        userRepository: context.read(),
        flutterSecureCredentialsStorage: context.read(),
      )..init(),
      child: const _SettingsContent(),
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    return AppScaffold(
      topBar: ConnectivityAppTopBar(
        title: s.navBar_settings,
        centerTitle: false,
      ),
      body: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) => switch (state) {
          MenuStateLoading() => const Center(
            child: AppLoadingOverlay(isLoading: true),
          ),
          MenuStateUnauthenticated() => const _LoadedSettings(menuState: null),
          MenuStateLoaded() => _LoadedSettings(menuState: state),
          MenuStateError() => ErrorPage(
            onTryAgain: context.read<MenuCubit>().refresh,
          ),
        },
      ),
    );
  }
}

class _LoadedSettings extends StatelessWidget {
  const _LoadedSettings({required this.menuState});

  final MenuStateLoaded? menuState;

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final loggedIn = authState is AuthStateLoggedIn;

    final s = l10n(context);
    return ListView(
      children: [
        if (menuState case MenuStateLoaded(:final traits) when loggedIn) ...[
          AppListItem(
            key: keys.settingsPage.accountItem,
            title: '${traits.givenName} ${traits.familyName}',
            subtitle: traits.email,
            leadingIcon: AppListItemIcon.icon(
              icon: AppStandardIcons.userCircle,
              semanticsLabel: s.profile_my_profile,
            ),
            trailingIcon: AppListItemIcon.icon(
              icon: AppStandardIcons.chevronRight,
              semanticsLabel: s.profile_my_profile,
            ),
            onTap: () => const AccountRoute().push<void>(context),
          ),
          const AppListDivider(),
        ] else
          const _SignUpTile(),

        AppSpacings.s24.verticalSpace,
        Semantics(
          header: true,
          child: AppText(
            s.settings_documents,
            style: AppTextStyles.captionDefault,
          ),
        ),
        AppSpacings.s8.verticalSpace,
        AppListItem(
          title: s.settings_rules,
          trailingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.chevronRight,
            semanticsLabel: s.settings_rules,
          ),
          onTap: () => const DocumentRoute(
            DocumentType.termsOfService,
          ).push<void>(context),
        ),
        const AppListDivider(),
        AppListItem(
          title: s.settings_privacyPolicy,
          trailingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.chevronRight,
            semanticsLabel: s.settings_privacyPolicy,
          ),
          onTap: () => const DocumentRoute(
            DocumentType.privacyPolicy,
          ).push<void>(context),
        ),
        const AppListDivider(),
        AppListItem(
          title: s.settings_openSourceLicenses,
          trailingIcon: AppListItemIcon.icon(
            icon: AppStandardIcons.chevronRight,
            semanticsLabel: s.settings_agreements,
          ),
          onTap: () => const LicenseRoute().push<void>(context),
        ),
        if (loggedIn) ...[
          const AppListDivider(),
          AppSpacings.s24.verticalSpace,
          Semantics(
            header: true,
            child: AppText(
              s.settings_other,
              style: AppTextStyles.captionDefault,
            ),
          ),
          AppSpacings.s8.verticalSpace,
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
      ],
    );
  }
}

class _SignUpTile extends StatelessWidget {
  const _SignUpTile();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    return Container(
      padding: AppSpacings.s24.all,
      decoration: BoxDecoration(
        color: colors.backgroundDefaultSecondary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            s.settings_signUpTileTitle,
            style: AppTextStyles.headlineSmall,
            color: context.colors.foregroundDefaultPrimary,
          ),
          AppSpacings.s12.verticalSpace,
          AppText(
            s.settings_signUpTileMessage,
            style: AppTextStyles.bodyDefault,
          ),
          AppSpacings.s8.verticalSpace,
          AppButton(
            key: keys.settingsPage.signUpButton,
            caption: s.settings_signUpTileButton,
            fullWidth: true,
            onTap: () => const RegisterRoute().push<void>(context),
            type: AppButtonType.primary,
            analyticsId: AnalyticsIds.settingsRegisterButton,
          ),
        ],
      ),
    );
  }
}
