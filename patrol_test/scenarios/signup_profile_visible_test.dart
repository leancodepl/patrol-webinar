import '../common/fts_test_wrapper.dart';
import '../common/open_app.dart';

void main() {
  ftsTest('Sign up and verify profile tile is visible', (
    $,
    modules,
    system,
    apiClients,
  ) async {
    final email = apiClients.mailpitClient.generateRandomEmailAddress();
    const password = 'Food1App!';

    await openApp($);
    await modules.onboarding.completeOnboarding();
    await system.grantPermission();

    await modules.home.openSettings();
    await modules.settings.navigateToSignUp();
    await modules.auth.fillRegistrationForm(
      email: email,
      firstName: 'Test',
      lastName: 'User',
    );
    await modules.auth.fillPasswordForm(password: password);

    await modules.home.waitForHomePage();
    await modules.home.openSettings();
    await modules.settings.waitForProfileTile();
  });
}
