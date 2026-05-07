import 'package:fts/keys.dart';

import 'module.dart';

final class Settings extends Module {
  const Settings(super.$);

  Future<void> navigateToSignUp() async {
    await $(keys.settingsPage.signUpButton).tap();
  }

  Future<void> openAccount() async {
    await $(keys.settingsPage.accountItem).tap();
  }

  Future<void> waitForLogoutButton() async {
    await $(keys.menu.logoutItem).waitUntilVisible();
  }

  Future<void> waitForSignUpButton() async {
    await $(keys.settingsPage.signUpButton).waitUntilVisible();
  }
}
