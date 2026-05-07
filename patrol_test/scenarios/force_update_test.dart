import 'package:leancode_force_update/data/contracts/contracts.dart';

import '../common/fts_test_wrapper.dart';
import '../common/open_app.dart';

void main() {
  ftsTest('Force update screen — update required, screen is shown', (
    $,
    modules,
    system,
    apiClients,
  ) async {
    await openApp($, versionSupport: VersionSupportResultDTO.updateRequired);
    await modules.appUpdate.waitForForceUpdateScreen();
  });
}
