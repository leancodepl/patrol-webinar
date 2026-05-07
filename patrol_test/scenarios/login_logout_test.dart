import '../common/env_variables.dart';
import '../common/fts_test_wrapper.dart';
import '../common/open_app.dart';

void main() {
  ftsTest('Login, logout, and login again', (
    $,
    modules,
    system,
    apiClients,
  ) async {
    await openApp($);
    await modules.onboarding.completeOnboarding();
    await system.grantPermission();
    await modules.home.openSettings();
    await modules.settings.navigateToSignUp();
    await modules.auth.navigateFromRegisterToLogin();
    await modules.auth.loginWithCredentials(
      email: V.email,
      password: V.password,
    );
    await modules.home.waitForHomePage();
    await modules.home.openSettings();
    await modules.auth.logout();
    await modules.settings.navigateToSignUp();
    await modules.auth.navigateFromRegisterToLogin();
    await modules.auth.loginWithCredentials(
      email: V.email,
      password: V.password,
    );
    await modules.home.waitForHomePage();
  });
}
