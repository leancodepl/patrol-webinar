import 'package:flutter/widgets.dart';

class _LoginPageKey extends ValueKey<String> {
  const _LoginPageKey(String value) : super('loginPage_$value');
}

class LoginPageKeys {
  final emailField = const _LoginPageKey('emailField');
  final loginButton = const _LoginPageKey('loginButton');
  final loginButtonOnRegisterPage = const _LoginPageKey(
    'loginButtonOnRegisterPage',
  );
  final passwordField = const _LoginPageKey('passwordField');
}

class _LoginWithCredentialsPageKey extends ValueKey<String> {
  const _LoginWithCredentialsPageKey(String value)
    : super('loginWithCredentialsPage_$value');
}

class LoginWithCredentialsPageKeys {
  final emailField = const _LoginWithCredentialsPageKey('emailField');
  final loginButton = const _LoginWithCredentialsPageKey('loginButton');
  final passwordField = const _LoginWithCredentialsPageKey('passwordField');
}

class _MenuPageKey extends ValueKey<String> {
  const _MenuPageKey(String value) : super('menuPage_$value');
}

class MenuPageKeys {
  final deleteAccountItem = const _MenuPageKey('deleteAccountItem');
  final deleteAccountConfirmButton = const _MenuPageKey(
    'deleteAccountConfirmButton',
  );
  final logoutItem = const _MenuPageKey('logoutItem');
}

class _RegisterPageKey extends ValueKey<String> {
  const _RegisterPageKey(String value) : super('registerPage_$value');
}

class RegisterPageKeys {
  final emailField = const _RegisterPageKey('emailField');
  final firstNameField = const _RegisterPageKey('firstNameField');
  final lastNameField = const _RegisterPageKey('lastNameField');
  final passwordField = const _RegisterPageKey('passwordField');
  final registerButton = const _RegisterPageKey('registerButton');
  final setPasswordButton = const _RegisterPageKey('setPasswordButton');
  final termsCheckbox = const _RegisterPageKey('termsCheckbox');
  final termsCheckboxBody = const _RegisterPageKey('termsCheckboxBody');
}

class _VerificationPageKey extends ValueKey<String> {
  const _VerificationPageKey(String value) : super('verificationPage_$value');
}

class VerificationPageKeys {
  final codeField = const _VerificationPageKey('codeField');
  final continueButton = const _VerificationPageKey('continueButton');
}
