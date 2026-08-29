import 'package:fts/keys.dart';

import 'module.dart';

final class Settings extends Module {
  const Settings(super.$);

  Future<void> navigateToSignUp() async {
    await $(keys.settingsPage.signUpButton).tap();
  }

  Future<void> openAccount() async {
    // The settings list mounts only after the profile fetch returns; its
    // items do not exist in the tree until then.
    await $(
      keys.settingsPage.accountItem,
    ).waitUntilExists(timeout: const Duration(seconds: 30));
    await $(keys.settingsPage.accountItem).tap();
  }

  Future<void> waitForLogoutButton() async {
    await $(keys.menu.logoutItem).waitUntilVisible();
  }

  Future<void> waitForSignUpButton() async {
    await $(keys.settingsPage.signUpButton).waitUntilVisible();
  }
}
