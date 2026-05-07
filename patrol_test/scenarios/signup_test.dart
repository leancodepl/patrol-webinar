import '../common/fts_test_wrapper.dart';
import '../common/open_app.dart';

void main() {
  ftsTest('Sign up, verify logged in, delete account', (
    $,
    modules,
    system,
    apiClients,
  ) async {
    final email = apiClients.mailpitClient.generateRandomEmailAddress();
    const password = 'TestPasswrd123!';

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
    await modules.settings.openAccount();
    await modules.auth.deleteAccount();

    await modules.settings.waitForSignUpButton();
  });
}
