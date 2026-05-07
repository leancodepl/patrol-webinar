import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/keys.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';

class ShellTopBar extends StatelessWidget {
  const ShellTopBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return AppTopBar(
      title: title,
      centerTitle: false,
      divider: false,
      actions: [
        AppTopBarAction.icon(
          key: keys.home.settingsButton,
          icon: AppStandardIcons.user01,
          semanticsLabel: s.settings_account_profile,
          onTap: () => const SettingsRoute().push<void>(context),
        ),
      ],
    );
  }
}
