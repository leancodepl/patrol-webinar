import 'package:fts/keys.dart';

import 'module.dart';

final class AppUpdate extends Module {
  const AppUpdate(super.$);

  Future<void> waitForForceUpdateScreen() async {
    await $(keys.appForceUpdateScreen.screen).waitUntilVisible();
  }

  Future<void> waitForSuggestUpdateDialog() async {
    await $(keys.appSuggestUpdateDialog.dialog).waitUntilVisible();
  }

  Future<void> dismissSuggestUpdateDialog() async {
    await $(keys.appSuggestUpdateDialog.cancelButton).tap();
  }
}
