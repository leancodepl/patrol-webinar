import 'package:leancode_force_update/data/contracts/contracts.dart';

import '../common/fts_test_wrapper.dart';
import '../common/open_app.dart';

void main() {
  ftsTest('Suggest update dialog — dismiss and continue to app', (
    $,
    modules,
    system,
    apiClients,
  ) async {
    await openApp($, versionSupport: VersionSupportResultDTO.updateSuggested);
    await modules.appUpdate.waitForSuggestUpdateDialog();
    await modules.appUpdate.dismissSuggestUpdateDialog();
  });
}
