import '../common/fts_test_wrapper.dart';
import '../common/open_app.dart';

void main() {
  ftsTest('Browse agenda, view session details', (
    $,
    modules,
    system,
    apiClients,
  ) async {
    await openApp($);
    await modules.onboarding.completeOnboarding();
    await system.grantPermission();
    await modules.home.waitForHomePage();
    await modules.home.goToAgenda();
    await modules.agenda.tapFirstSession();
    await modules.sessionDetails.waitForSessionDetailsPage();
  });
}
