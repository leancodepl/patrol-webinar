import '../common/fts_test_wrapper.dart';
import '../common/open_app.dart';

void main() {
  ftsTest('Browse home page and view speaker details', (
    $,
    modules,
    system,
    apiClients,
  ) async {
    await openApp($);
    await modules.onboarding.completeOnboarding();
    await system.grantPermission();
    await modules.home.waitForHomePage();
    await modules.home.tapFirstSpeaker();
    await modules.speakerDetails.waitForSpeakerDetailsPage();
  });
}
