import 'package:fts/keys.dart';
import 'package:patrol/patrol.dart';

import 'module.dart';

final class Auth extends Module {
  const Auth(super.$);

  Future<void> navigateFromRegisterToLogin() async {
    await $(keys.loginPage.loginButtonOnRegisterPage).tap();
  }

  Future<void> fillRegistrationForm({
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    await $(keys.registerPage.emailField).enterText(email);
    await $(keys.registerPage.firstNameField).enterText(firstName);
    await $(keys.registerPage.lastNameField).enterText(lastName);
    await $(keys.registerPage.termsCheckboxBody).scrollTo().tap();
    await $(keys.registerPage.registerButton).scrollTo().tap();
  }

  Future<void> fillPasswordForm({required String password}) async {
    await $(keys.registerPage.passwordField).enterText(password);
    await $(keys.registerPage.setPasswordButton).scrollTo().tap();
  }

  Future<void> enterVerificationCode(String code) async {
    await $(keys.verificationPage.codeField).enterText(code);
    await $(keys.verificationPage.continueButton).scrollTo().tap();
  }

  Future<void> loginWithCredentials({
    required String email,
    required String password,
  }) async {
    await $(keys.loginPage.emailField).enterText(email);
    await $(keys.loginPage.passwordField).enterText(password);
    await $(keys.loginPage.loginButton).scrollTo().tap();
  }

  Future<void> deleteAccount() async {
    await $(keys.menu.deleteAccountItem).tap();
    await $(keys.menu.deleteAccountConfirmButton).tap();
  }

  Future<void> logout() async {
    await $(keys.menu.logoutItem).scrollTo().tap();
  }

  Future<void> waitForLoginPage() async {
    await $(keys.loginPage.emailField).waitUntilVisible();
  }
}
