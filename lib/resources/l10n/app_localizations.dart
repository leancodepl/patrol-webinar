import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @add_passkey_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while adding the passkey. Try again.'**
  String get add_passkey_error;

  /// No description provided for @add_passkey_success.
  ///
  /// In en, this message translates to:
  /// **'Passkey added successfully'**
  String get add_passkey_success;

  /// No description provided for @add_passkey_title.
  ///
  /// In en, this message translates to:
  /// **'Add Passkey'**
  String get add_passkey_title;

  /// No description provided for @agenda_title.
  ///
  /// In en, this message translates to:
  /// **'Agenda'**
  String get agenda_title;

  /// No description provided for @app_error_view_retry_button.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get app_error_view_retry_button;

  /// No description provided for @app_error_view_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Try again later'**
  String get app_error_view_subtitle;

  /// No description provided for @app_error_view_title.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get app_error_view_title;

  /// No description provided for @common_app_name.
  ///
  /// In en, this message translates to:
  /// **'Flutter Tech Summit'**
  String get common_app_name;

  /// No description provided for @common_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get common_back;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @common_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get common_close;

  /// No description provided for @common_error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get common_error;

  /// No description provided for @common_menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get common_menu;

  /// No description provided for @common_rateTalkButton.
  ///
  /// In en, this message translates to:
  /// **'Rate this talk'**
  String get common_rateTalkButton;

  /// No description provided for @common_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_save;

  /// No description provided for @common_sortAscending.
  ///
  /// In en, this message translates to:
  /// **'Ascending'**
  String get common_sortAscending;

  /// No description provided for @common_sortDescending.
  ///
  /// In en, this message translates to:
  /// **'Descending'**
  String get common_sortDescending;

  /// No description provided for @common_speakerLongDescription.
  ///
  /// In en, this message translates to:
  /// **'{jobTitle}, {companyName}'**
  String common_speakerLongDescription({
    required String jobTitle,
    required String companyName,
  });

  /// No description provided for @connectivityBanner_connectionRestored.
  ///
  /// In en, this message translates to:
  /// **'Server connection restored'**
  String get connectivityBanner_connectionRestored;

  /// No description provided for @connectivityBanner_connectionUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Server connection lost'**
  String get connectivityBanner_connectionUnavailable;

  /// No description provided for @continue_registration.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_registration;

  /// No description provided for @delete_account_cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get delete_account_cancelButton;

  /// No description provided for @delete_account_confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get delete_account_confirmButton;

  /// No description provided for @delete_account_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting your account, please try again.'**
  String get delete_account_error;

  /// No description provided for @delete_account_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?'**
  String get delete_account_subtitle;

  /// No description provided for @delete_account_success.
  ///
  /// In en, this message translates to:
  /// **'Your account has been successfully deleted'**
  String get delete_account_success;

  /// No description provided for @delete_account_title.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get delete_account_title;

  /// No description provided for @email_field.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get email_field;

  /// No description provided for @enter_code_email.
  ///
  /// In en, this message translates to:
  /// **'Enter the code from e-mail'**
  String get enter_code_email;

  /// No description provided for @errorState_message.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again'**
  String get errorState_message;

  /// No description provided for @errorState_title.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get errorState_title;

  /// No description provided for @errorState_tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get errorState_tryAgain;

  /// No description provided for @error_handling_authorization.
  ///
  /// In en, this message translates to:
  /// **'No permission, go back'**
  String get error_handling_authorization;

  /// No description provided for @error_handling_network.
  ///
  /// In en, this message translates to:
  /// **'No internet connection, try again later'**
  String get error_handling_network;

  /// No description provided for @error_handling_unknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, try again'**
  String get error_handling_unknown;

  /// No description provided for @error_verification.
  ///
  /// In en, this message translates to:
  /// **'Error during verification'**
  String get error_verification;

  /// No description provided for @force_update_screen_subtitle.
  ///
  /// In en, this message translates to:
  /// **'New version is available, download it to continue'**
  String get force_update_screen_subtitle;

  /// No description provided for @force_update_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Update app'**
  String get force_update_screen_title;

  /// No description provided for @force_update_screen_updateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get force_update_screen_updateButton;

  /// No description provided for @forgot_password_button.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgot_password_button;

  /// No description provided for @home_brandingTileDate.
  ///
  /// In en, this message translates to:
  /// **'Warsaw, 5th June'**
  String get home_brandingTileDate;

  /// No description provided for @home_brandingTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The only tech event for mobile executives'**
  String get home_brandingTileSubtitle;

  /// No description provided for @home_brandingTileTitle.
  ///
  /// In en, this message translates to:
  /// **'FLUTTER TECH SUMMIT'**
  String get home_brandingTileTitle;

  /// No description provided for @home_fullAgenda.
  ///
  /// In en, this message translates to:
  /// **'Full agenda'**
  String get home_fullAgenda;

  /// No description provided for @home_moderatorsCarouselTitle.
  ///
  /// In en, this message translates to:
  /// **'Meet the moderators'**
  String get home_moderatorsCarouselTitle;

  /// No description provided for @home_speakersCarouselTitle.
  ///
  /// In en, this message translates to:
  /// **'Meet the speakers'**
  String get home_speakersCarouselTitle;

  /// No description provided for @home_title.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_title;

  /// No description provided for @home_whatsNext.
  ///
  /// In en, this message translates to:
  /// **'What\'s next'**
  String get home_whatsNext;

  /// No description provided for @identities_title.
  ///
  /// In en, this message translates to:
  /// **'Identities'**
  String get identities_title;

  /// No description provided for @kratos_error_system.
  ///
  /// In en, this message translates to:
  /// **'System error'**
  String get kratos_error_system;

  /// No description provided for @kratos_error_system_generic.
  ///
  /// In en, this message translates to:
  /// **'Generic error'**
  String get kratos_error_system_generic;

  /// No description provided for @kratos_error_validation_address_not_verified.
  ///
  /// In en, this message translates to:
  /// **'Account not active yet. Did you forget to verify your email address?'**
  String get kratos_error_validation_address_not_verified;

  /// No description provided for @kratos_error_validation_const_failed.
  ///
  /// In en, this message translates to:
  /// **'Const failed'**
  String get kratos_error_validation_const_failed;

  /// No description provided for @kratos_error_validation_credential_already_used_by_another_account.
  ///
  /// In en, this message translates to:
  /// **'Credentials {credentialIdentifierHint} already used by another account. Try sign in using {availableCredentialTypesList}, or use social sign in providers'**
  String kratos_error_validation_credential_already_used_by_another_account({
    required String credentialIdentifierHint,
    required String availableCredentialTypesList,
  });

  /// No description provided for @kratos_error_validation_duplicate_credentials.
  ///
  /// In en, this message translates to:
  /// **'An account with this login information already exists'**
  String get kratos_error_validation_duplicate_credentials;

  /// No description provided for @kratos_error_validation_duplicate_credentials_on_oidc_link.
  ///
  /// In en, this message translates to:
  /// **'An account with the same identifier exists already'**
  String get kratos_error_validation_duplicate_credentials_on_oidc_link;

  /// No description provided for @kratos_error_validation_exclusive_maximum.
  ///
  /// In en, this message translates to:
  /// **'Must be < {maximum} but found {actual}'**
  String kratos_error_validation_exclusive_maximum({
    required int maximum,
    required int actual,
  });

  /// No description provided for @kratos_error_validation_exclusive_minimum.
  ///
  /// In en, this message translates to:
  /// **'Must be > {minimum} but found {actual}'**
  String kratos_error_validation_exclusive_minimum({
    required int minimum,
    required int actual,
  });

  /// No description provided for @kratos_error_validation_generic.
  ///
  /// In en, this message translates to:
  /// **'{reason}'**
  String kratos_error_validation_generic({required String reason});

  /// No description provided for @kratos_error_validation_identifier_missing.
  ///
  /// In en, this message translates to:
  /// **'Could not find any login identifiers. Did you forget to set them? This could also be caused by a server misconfiguration'**
  String get kratos_error_validation_identifier_missing;

  /// No description provided for @kratos_error_validation_invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address or password'**
  String get kratos_error_validation_invalid_credentials;

  /// No description provided for @kratos_error_validation_invalid_format.
  ///
  /// In en, this message translates to:
  /// **'Does not match pattern \"{pattern}\"'**
  String kratos_error_validation_invalid_format({required String pattern});

  /// No description provided for @kratos_error_validation_linked_credentials_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Credentials do not match'**
  String get kratos_error_validation_linked_credentials_do_not_match;

  /// No description provided for @kratos_error_validation_login_code_invalid_or_already_used.
  ///
  /// In en, this message translates to:
  /// **'Login code invalid or used'**
  String get kratos_error_validation_login_code_invalid_or_already_used;

  /// No description provided for @kratos_error_validation_login_flow_expired.
  ///
  /// In en, this message translates to:
  /// **'The login flow expired {timeAgo}, please try again.'**
  String kratos_error_validation_login_flow_expired({required String timeAgo});

  /// No description provided for @kratos_error_validation_login_no_strategy_found.
  ///
  /// In en, this message translates to:
  /// **'Could not find a strategy to log you in with. Did you fill out the form correctly?'**
  String get kratos_error_validation_login_no_strategy_found;

  /// No description provided for @kratos_error_validation_login_request_already_completed.
  ///
  /// In en, this message translates to:
  /// **'Request already completed'**
  String get kratos_error_validation_login_request_already_completed;

  /// No description provided for @kratos_error_validation_lookup_already_used.
  ///
  /// In en, this message translates to:
  /// **'The recovery code has already been redeemed'**
  String get kratos_error_validation_lookup_already_used;

  /// No description provided for @kratos_error_validation_lookup_invalid.
  ///
  /// In en, this message translates to:
  /// **'The backup recovery code is not valid'**
  String get kratos_error_validation_lookup_invalid;

  /// No description provided for @kratos_error_validation_max_items.
  ///
  /// In en, this message translates to:
  /// **'Maximum {maxItems} items allowed, but found {actualItems} items'**
  String kratos_error_validation_max_items({
    required int maxItems,
    required int actualItems,
  });

  /// No description provided for @kratos_error_validation_max_length.
  ///
  /// In en, this message translates to:
  /// **'Length must be <= {maxLength}, but got {actualLength}'**
  String kratos_error_validation_max_length({
    required int maxLength,
    required int actualLength,
  });

  /// No description provided for @kratos_error_validation_maximum.
  ///
  /// In en, this message translates to:
  /// **'Must be <= {maximum} but found {actual}'**
  String kratos_error_validation_maximum({
    required int maximum,
    required int actual,
  });

  /// No description provided for @kratos_error_validation_min_items.
  ///
  /// In en, this message translates to:
  /// **'Minimum {minItems} items allowed, but found {actualItems} items'**
  String kratos_error_validation_min_items({
    required int minItems,
    required int actualItems,
  });

  /// No description provided for @kratos_error_validation_min_length.
  ///
  /// In en, this message translates to:
  /// **'Must be >= {minimum} but found {actual}'**
  String kratos_error_validation_min_length({
    required int minimum,
    required int actual,
  });

  /// No description provided for @kratos_error_validation_multiple_of.
  ///
  /// In en, this message translates to:
  /// **'{actual} not multipleOf {base}'**
  String kratos_error_validation_multiple_of({
    required int actual,
    required int base,
  });

  /// No description provided for @kratos_error_validation_must_be_equal_to_constant.
  ///
  /// In en, this message translates to:
  /// **'Must be equal to constant: {expected}'**
  String kratos_error_validation_must_be_equal_to_constant({
    required String expected,
  });

  /// No description provided for @kratos_error_validation_no_account_or_no_code_sign_in_set_up.
  ///
  /// In en, this message translates to:
  /// **'No account or no code sign in set up'**
  String get kratos_error_validation_no_account_or_no_code_sign_in_set_up;

  /// No description provided for @kratos_error_validation_no_lookup.
  ///
  /// In en, this message translates to:
  /// **'You have no backup recovery codes set up'**
  String get kratos_error_validation_no_lookup;

  /// No description provided for @kratos_error_validation_no_totp_device.
  ///
  /// In en, this message translates to:
  /// **'You have no TOTP device set up'**
  String get kratos_error_validation_no_totp_device;

  /// No description provided for @kratos_error_validation_no_web_authn_device.
  ///
  /// In en, this message translates to:
  /// **'You have no WebAuthn device set up'**
  String get kratos_error_validation_no_web_authn_device;

  /// No description provided for @kratos_error_validation_password_found_in_data_breaches.
  ///
  /// In en, this message translates to:
  /// **'Password found in data breaches'**
  String get kratos_error_validation_password_found_in_data_breaches;

  /// No description provided for @kratos_error_validation_password_policy_violation.
  ///
  /// In en, this message translates to:
  /// **'The password can not be used because {reason}'**
  String kratos_error_validation_password_policy_violation({
    required String reason,
  });

  /// No description provided for @kratos_error_validation_password_too_long.
  ///
  /// In en, this message translates to:
  /// **'Password too long, must have at most {maxLength} characters, but got {actualLength}'**
  String kratos_error_validation_password_too_long({
    required int maxLength,
    required int actualLength,
  });

  /// No description provided for @kratos_error_validation_password_too_short.
  ///
  /// In en, this message translates to:
  /// **'Password too short, must have at least {minLength} characters, but got {actualLength}'**
  String kratos_error_validation_password_too_short({
    required int minLength,
    required int actualLength,
  });

  /// No description provided for @kratos_error_validation_password_too_similar_to_identifier.
  ///
  /// In en, this message translates to:
  /// **'Password too similar to identifier'**
  String get kratos_error_validation_password_too_similar_to_identifier;

  /// No description provided for @kratos_error_validation_recovery_code_invalid_or_already_used.
  ///
  /// In en, this message translates to:
  /// **'The recovery code is invalid or has already been used'**
  String get kratos_error_validation_recovery_code_invalid_or_already_used;

  /// No description provided for @kratos_error_validation_recovery_flow_expired.
  ///
  /// In en, this message translates to:
  /// **'The recovery flow expired {timeAgo}, please try again'**
  String kratos_error_validation_recovery_flow_expired({
    required String timeAgo,
  });

  /// No description provided for @kratos_error_validation_recovery_no_strategy_found.
  ///
  /// In en, this message translates to:
  /// **'Could not find a strategy to recover your account with. Did you fill out the form correctly?'**
  String get kratos_error_validation_recovery_no_strategy_found;

  /// No description provided for @kratos_error_validation_recovery_retry_success.
  ///
  /// In en, this message translates to:
  /// **'The request has already been sent successfully and cannot be repeated'**
  String get kratos_error_validation_recovery_retry_success;

  /// No description provided for @kratos_error_validation_recovery_state_failure.
  ///
  /// In en, this message translates to:
  /// **'The recovery flow reached a failure state and must be retried'**
  String get kratos_error_validation_recovery_state_failure;

  /// No description provided for @kratos_error_validation_recovery_token_invalid_or_already_used.
  ///
  /// In en, this message translates to:
  /// **'The code is invalid or has already been used'**
  String get kratos_error_validation_recovery_token_invalid_or_already_used;

  /// No description provided for @kratos_error_validation_registration_code_invalid_or_already_used.
  ///
  /// In en, this message translates to:
  /// **'Registration code invalid or used'**
  String get kratos_error_validation_registration_code_invalid_or_already_used;

  /// No description provided for @kratos_error_validation_registration_flow_expired.
  ///
  /// In en, this message translates to:
  /// **'The registration flow expired {timeAgo}, please try again.'**
  String kratos_error_validation_registration_flow_expired({
    required String timeAgo,
  });

  /// No description provided for @kratos_error_validation_registration_no_strategy_found.
  ///
  /// In en, this message translates to:
  /// **'Could not find a strategy to sign you up with. Did you fill out the form correctly?'**
  String get kratos_error_validation_registration_no_strategy_found;

  /// No description provided for @kratos_error_validation_registration_request_already_completed.
  ///
  /// In en, this message translates to:
  /// **'Request already completed'**
  String get kratos_error_validation_registration_request_already_completed;

  /// No description provided for @kratos_error_validation_required.
  ///
  /// In en, this message translates to:
  /// **'Property {property} is missing'**
  String kratos_error_validation_required({required String property});

  /// No description provided for @kratos_error_validation_settings_flow_expired.
  ///
  /// In en, this message translates to:
  /// **'The settings flow expired {timeAgo}, please try again'**
  String kratos_error_validation_settings_flow_expired({
    required String timeAgo,
  });

  /// No description provided for @kratos_error_validation_settings_no_strategy_found.
  ///
  /// In en, this message translates to:
  /// **'Could not find a strategy to update your settings. Did you fill out the form correctly?'**
  String get kratos_error_validation_settings_no_strategy_found;

  /// No description provided for @kratos_error_validation_such_no_web_authn_user.
  ///
  /// In en, this message translates to:
  /// **'This account does not exist or has no security key set up'**
  String get kratos_error_validation_such_no_web_authn_user;

  /// No description provided for @kratos_error_validation_totp_verifier_wrong.
  ///
  /// In en, this message translates to:
  /// **'The verification code you entered is invalid'**
  String get kratos_error_validation_totp_verifier_wrong;

  /// No description provided for @kratos_error_validation_traits_dont_match_previously_associated.
  ///
  /// In en, this message translates to:
  /// **'Traits don\'t match previously associated'**
  String get kratos_error_validation_traits_dont_match_previously_associated;

  /// No description provided for @kratos_error_validation_unique_items.
  ///
  /// In en, this message translates to:
  /// **'Items at index {indexA} and {indexB} are equal'**
  String kratos_error_validation_unique_items({
    required int indexA,
    required int indexB,
  });

  /// No description provided for @kratos_error_validation_verification_code_invalid_or_already_used.
  ///
  /// In en, this message translates to:
  /// **'The verification code is invalid or has already been used. Try again'**
  String get kratos_error_validation_verification_code_invalid_or_already_used;

  /// No description provided for @kratos_error_validation_verification_flow_expired.
  ///
  /// In en, this message translates to:
  /// **'The verification flow expired {timeAgo}, please try again'**
  String kratos_error_validation_verification_flow_expired({
    required String timeAgo,
  });

  /// No description provided for @kratos_error_validation_verification_missing_verification_token.
  ///
  /// In en, this message translates to:
  /// **'The verification token is missing, please provide a valid token'**
  String get kratos_error_validation_verification_missing_verification_token;

  /// No description provided for @kratos_error_validation_verification_no_strategy_found.
  ///
  /// In en, this message translates to:
  /// **'Could not find a strategy to verify your account with. Did you fill out the form correctly?'**
  String get kratos_error_validation_verification_no_strategy_found;

  /// No description provided for @kratos_error_validation_verification_retry_success.
  ///
  /// In en, this message translates to:
  /// **'The request was already completed successfully and can not be retried'**
  String get kratos_error_validation_verification_retry_success;

  /// No description provided for @kratos_error_validation_verification_state_failure.
  ///
  /// In en, this message translates to:
  /// **'The verification flow reached a failure state and must be retried'**
  String get kratos_error_validation_verification_state_failure;

  /// No description provided for @kratos_error_validation_verification_token_invalid_or_already_used.
  ///
  /// In en, this message translates to:
  /// **'The code is invalid or has already been used'**
  String get kratos_error_validation_verification_token_invalid_or_already_used;

  /// No description provided for @kratos_error_validation_wrong_type.
  ///
  /// In en, this message translates to:
  /// **'Expected {allowedTypesList}, but got {actualType}'**
  String kratos_error_validation_wrong_type({
    required String allowedTypesList,
    required String actualType,
  });

  /// No description provided for @kratos_info_login_lookup.
  ///
  /// In en, this message translates to:
  /// **'Use backup recovery code'**
  String get kratos_info_login_lookup;

  /// No description provided for @kratos_info_login_lookup_label.
  ///
  /// In en, this message translates to:
  /// **'Backup recovery code'**
  String get kratos_info_login_lookup_label;

  /// No description provided for @kratos_info_login_totp.
  ///
  /// In en, this message translates to:
  /// **'Use Authenticator'**
  String get kratos_info_login_totp;

  /// No description provided for @kratos_info_node_label_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get kratos_info_node_label_continue;

  /// No description provided for @kratos_info_node_label_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get kratos_info_node_label_email;

  /// No description provided for @kratos_info_node_label_generated.
  ///
  /// In en, this message translates to:
  /// **'{title}'**
  String kratos_info_node_label_generated({required String title});

  /// No description provided for @kratos_info_node_label_id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get kratos_info_node_label_id;

  /// No description provided for @kratos_info_node_label_input_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get kratos_info_node_label_input_password;

  /// No description provided for @kratos_info_node_label_login_and_link_credential.
  ///
  /// In en, this message translates to:
  /// **'Log in and link credential'**
  String get kratos_info_node_label_login_and_link_credential;

  /// No description provided for @kratos_info_node_label_login_code.
  ///
  /// In en, this message translates to:
  /// **'Login code'**
  String get kratos_info_node_label_login_code;

  /// No description provided for @kratos_info_node_label_recovery_code.
  ///
  /// In en, this message translates to:
  /// **'Recovery code'**
  String get kratos_info_node_label_recovery_code;

  /// No description provided for @kratos_info_node_label_registration_code.
  ///
  /// In en, this message translates to:
  /// **'Registration code'**
  String get kratos_info_node_label_registration_code;

  /// No description provided for @kratos_info_node_label_resend_otp.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get kratos_info_node_label_resend_otp;

  /// No description provided for @kratos_info_node_label_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get kratos_info_node_label_save;

  /// No description provided for @kratos_info_node_label_submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get kratos_info_node_label_submit;

  /// No description provided for @kratos_info_node_label_verification_code.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get kratos_info_node_label_verification_code;

  /// No description provided for @kratos_info_node_label_verify_otp.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get kratos_info_node_label_verify_otp;

  /// No description provided for @kratos_info_self_service_email_has_been_sent.
  ///
  /// In en, this message translates to:
  /// **'Email has been sent'**
  String get kratos_info_self_service_email_has_been_sent;

  /// No description provided for @kratos_info_self_service_login.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get kratos_info_self_service_login;

  /// No description provided for @kratos_info_self_service_login_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get kratos_info_self_service_login_continue;

  /// No description provided for @kratos_info_self_service_login_continue_web_authn.
  ///
  /// In en, this message translates to:
  /// **'Continue with security key'**
  String get kratos_info_self_service_login_continue_web_authn;

  /// No description provided for @kratos_info_self_service_login_mfa.
  ///
  /// In en, this message translates to:
  /// **'Please complete the second authentication challenge'**
  String get kratos_info_self_service_login_mfa;

  /// No description provided for @kratos_info_self_service_login_re_auth.
  ///
  /// In en, this message translates to:
  /// **'Please confirm this action by verifying that it is you'**
  String get kratos_info_self_service_login_re_auth;

  /// No description provided for @kratos_info_self_service_login_totp_label.
  ///
  /// In en, this message translates to:
  /// **'Authentication code'**
  String get kratos_info_self_service_login_totp_label;

  /// No description provided for @kratos_info_self_service_login_verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get kratos_info_self_service_login_verify;

  /// No description provided for @kratos_info_self_service_login_web_authn.
  ///
  /// In en, this message translates to:
  /// **'Use security key'**
  String get kratos_info_self_service_login_web_authn;

  /// No description provided for @kratos_info_self_service_login_web_authn_passwordless.
  ///
  /// In en, this message translates to:
  /// **'Prepare your WebAuthn device (e.g. security key, biometrics scanner, ...) and press continue.'**
  String get kratos_info_self_service_login_web_authn_passwordless;

  /// No description provided for @kratos_info_self_service_login_with.
  ///
  /// In en, this message translates to:
  /// **'Sign in with {provider}'**
  String kratos_info_self_service_login_with({required String provider});

  /// No description provided for @kratos_info_self_service_recovery_email_sent.
  ///
  /// In en, this message translates to:
  /// **'We have sent you an email with a link to reset your password to the email address you provided.'**
  String get kratos_info_self_service_recovery_email_sent;

  /// No description provided for @kratos_info_self_service_recovery_email_with_code_sent.
  ///
  /// In en, this message translates to:
  /// **'We have sent an email containing a recovery code to the email address you provided.'**
  String get kratos_info_self_service_recovery_email_with_code_sent;

  /// No description provided for @kratos_info_self_service_recovery_successful.
  ///
  /// In en, this message translates to:
  /// **'Account recovered successfully. Please change your password or set up an alternative login method.'**
  String get kratos_info_self_service_recovery_successful;

  /// No description provided for @kratos_info_self_service_registration.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get kratos_info_self_service_registration;

  /// No description provided for @kratos_info_self_service_registration_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get kratos_info_self_service_registration_continue;

  /// No description provided for @kratos_info_self_service_registration_email_has_been_sent.
  ///
  /// In en, this message translates to:
  /// **'Email has been sent'**
  String get kratos_info_self_service_registration_email_has_been_sent;

  /// No description provided for @kratos_info_self_service_registration_register_web_authn.
  ///
  /// In en, this message translates to:
  /// **'Sign up with security key'**
  String get kratos_info_self_service_registration_register_web_authn;

  /// No description provided for @kratos_info_self_service_registration_register_with_code.
  ///
  /// In en, this message translates to:
  /// **'Register with code'**
  String get kratos_info_self_service_registration_register_with_code;

  /// No description provided for @kratos_info_self_service_registration_with.
  ///
  /// In en, this message translates to:
  /// **'Sign up with {provider}'**
  String kratos_info_self_service_registration_with({required String provider});

  /// No description provided for @kratos_info_self_service_settings_disable_lookup.
  ///
  /// In en, this message translates to:
  /// **'Disable this method'**
  String get kratos_info_self_service_settings_disable_lookup;

  /// No description provided for @kratos_info_self_service_settings_lookup_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm backup recovery codes'**
  String get kratos_info_self_service_settings_lookup_confirm;

  /// No description provided for @kratos_info_self_service_settings_lookup_secret.
  ///
  /// In en, this message translates to:
  /// **'{secret}'**
  String kratos_info_self_service_settings_lookup_secret({
    required String secret,
  });

  /// No description provided for @kratos_info_self_service_settings_lookup_secret_label.
  ///
  /// In en, this message translates to:
  /// **'These are your back up recovery codes. Keep them in safe place, and use it if you can not scan the QR code.'**
  String get kratos_info_self_service_settings_lookup_secret_label;

  /// No description provided for @kratos_info_self_service_settings_lookup_secret_list.
  ///
  /// In en, this message translates to:
  /// **'{secretsList}'**
  String kratos_info_self_service_settings_lookup_secret_list({
    required String secretsList,
  });

  /// No description provided for @kratos_info_self_service_settings_lookup_secret_used.
  ///
  /// In en, this message translates to:
  /// **'Secret was used at {usedAt}'**
  String kratos_info_self_service_settings_lookup_secret_used({
    required String usedAt,
  });

  /// No description provided for @kratos_info_self_service_settings_regenerate_lookup.
  ///
  /// In en, this message translates to:
  /// **'Generate new backup recovery codes'**
  String get kratos_info_self_service_settings_regenerate_lookup;

  /// No description provided for @kratos_info_self_service_settings_register_web_authn.
  ///
  /// In en, this message translates to:
  /// **'Add security key'**
  String get kratos_info_self_service_settings_register_web_authn;

  /// No description provided for @kratos_info_self_service_settings_register_web_authn_display_name.
  ///
  /// In en, this message translates to:
  /// **'Name of the security key'**
  String get kratos_info_self_service_settings_register_web_authn_display_name;

  /// No description provided for @kratos_info_self_service_settings_remove_passkey.
  ///
  /// In en, this message translates to:
  /// **'Remove passkey \"{displayName}\"'**
  String kratos_info_self_service_settings_remove_passkey({
    required String displayName,
  });

  /// No description provided for @kratos_info_self_service_settings_remove_web_authn.
  ///
  /// In en, this message translates to:
  /// **'Remove security key \"{displayName}\"'**
  String kratos_info_self_service_settings_remove_web_authn({
    required String displayName,
  });

  /// No description provided for @kratos_info_self_service_settings_reveal_lookup.
  ///
  /// In en, this message translates to:
  /// **'Reveal backup recovery codes'**
  String get kratos_info_self_service_settings_reveal_lookup;

  /// No description provided for @kratos_info_self_service_settings_totp_qrcode.
  ///
  /// In en, this message translates to:
  /// **'Authenticator app QR code'**
  String get kratos_info_self_service_settings_totp_qrcode;

  /// No description provided for @kratos_info_self_service_settings_totp_secret.
  ///
  /// In en, this message translates to:
  /// **'{secret}'**
  String kratos_info_self_service_settings_totp_secret({
    required String secret,
  });

  /// No description provided for @kratos_info_self_service_settings_totp_secret_label.
  ///
  /// In en, this message translates to:
  /// **'This is your authenticator app secret. Use it if you can not scan the QR code'**
  String get kratos_info_self_service_settings_totp_secret_label;

  /// No description provided for @kratos_info_self_service_settings_update_link_oidc.
  ///
  /// In en, this message translates to:
  /// **'Link {provider}'**
  String kratos_info_self_service_settings_update_link_oidc({
    required String provider,
  });

  /// No description provided for @kratos_info_self_service_settings_update_success.
  ///
  /// In en, this message translates to:
  /// **'Your changes have been saved!'**
  String get kratos_info_self_service_settings_update_success;

  /// No description provided for @kratos_info_self_service_settings_update_unlink_oidc.
  ///
  /// In en, this message translates to:
  /// **'Unlink {provider}'**
  String kratos_info_self_service_settings_update_unlink_oidc({
    required String provider,
  });

  /// No description provided for @kratos_info_self_service_settings_update_unlink_totp.
  ///
  /// In en, this message translates to:
  /// **'Unlink TOTP Authenticator App'**
  String get kratos_info_self_service_settings_update_unlink_totp;

  /// No description provided for @kratos_info_self_service_sign_in_and_link.
  ///
  /// In en, this message translates to:
  /// **'Sign in and link'**
  String get kratos_info_self_service_sign_in_and_link;

  /// No description provided for @kratos_info_self_service_sign_in_with_code.
  ///
  /// In en, this message translates to:
  /// **'Sign in with code'**
  String get kratos_info_self_service_sign_in_with_code;

  /// No description provided for @kratos_info_self_service_signing_in_will_link_your_account.
  ///
  /// In en, this message translates to:
  /// **'{duplicateIdentifier} is already linked. Sign in with \"{provider}\" to connect accounts'**
  String kratos_info_self_service_signing_in_will_link_your_account({
    required String duplicateIdentifier,
    required String provider,
  });

  /// No description provided for @kratos_info_self_service_verification_email_sent.
  ///
  /// In en, this message translates to:
  /// **'An email with a verification link has been sent to the address you provided'**
  String get kratos_info_self_service_verification_email_sent;

  /// No description provided for @kratos_info_self_service_verification_email_with_code_sent.
  ///
  /// In en, this message translates to:
  /// **'An email with a verification code has been sent to the address you provided'**
  String get kratos_info_self_service_verification_email_with_code_sent;

  /// No description provided for @kratos_info_self_service_verification_successful.
  ///
  /// In en, this message translates to:
  /// **'Your email address has been confirmed'**
  String get kratos_info_self_service_verification_successful;

  /// No description provided for @kratos_info_selfservice_sign_in_and_link_credential.
  ///
  /// In en, this message translates to:
  /// **'Confirm with {provider}'**
  String kratos_info_selfservice_sign_in_and_link_credential({
    required String provider,
  });

  /// No description provided for @kratos_info_send_code_to.
  ///
  /// In en, this message translates to:
  /// **'Send code to {address}'**
  String kratos_info_send_code_to({required String address});

  /// No description provided for @languageSelector_hint.
  ///
  /// In en, this message translates to:
  /// **'Tap the button to open a language selection menu'**
  String get languageSelector_hint;

  /// No description provided for @languageSelector_label.
  ///
  /// In en, this message translates to:
  /// **'Currently selected language is '**
  String get languageSelector_label;

  /// No description provided for @languageSelector_openMenu.
  ///
  /// In en, this message translates to:
  /// **'Open language selection menu'**
  String get languageSelector_openMenu;

  /// No description provided for @languageSelector_selected.
  ///
  /// In en, this message translates to:
  /// **'Currently selected language'**
  String get languageSelector_selected;

  /// No description provided for @loginPage_title.
  ///
  /// In en, this message translates to:
  /// **'Log in to FTS'**
  String get loginPage_title;

  /// No description provided for @login_button.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login_button;

  /// No description provided for @login_header.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login_header;

  /// No description provided for @login_login_method_not_added_to_account_message.
  ///
  /// In en, this message translates to:
  /// **'This login method has not been added to your account. Please log in using another method'**
  String get login_login_method_not_added_to_account_message;

  /// No description provided for @login_no_account_caption.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get login_no_account_caption;

  /// No description provided for @login_page_recovery_button.
  ///
  /// In en, this message translates to:
  /// **'I forgot my password'**
  String get login_page_recovery_button;

  /// No description provided for @login_signup_button.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up'**
  String get login_signup_button;

  /// No description provided for @login_social_caption.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get login_social_caption;

  /// No description provided for @login_unknown_error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, try again'**
  String get login_unknown_error;

  /// No description provided for @login_verify_account_button.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get login_verify_account_button;

  /// No description provided for @login_verify_account_button_timed.
  ///
  /// In en, this message translates to:
  /// **'Resend code | {value}'**
  String login_verify_account_button_timed({required String value});

  /// No description provided for @login_verify_account_header.
  ///
  /// In en, this message translates to:
  /// **'To log in you need to verify your email'**
  String get login_verify_account_header;

  /// No description provided for @login_verify_account_resend_button.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get the code? Send again'**
  String get login_verify_account_resend_button;

  /// No description provided for @login_verify_account_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You can click on a verification link sent in the previous email or send it again using the button below'**
  String get login_verify_account_subtitle;

  /// No description provided for @login_with_apple_button.
  ///
  /// In en, this message translates to:
  /// **'Log in with Apple'**
  String get login_with_apple_button;

  /// No description provided for @login_with_email.
  ///
  /// In en, this message translates to:
  /// **'Log in with an e-mail'**
  String get login_with_email;

  /// No description provided for @login_with_facebook_button.
  ///
  /// In en, this message translates to:
  /// **'Log in with Facebook'**
  String get login_with_facebook_button;

  /// No description provided for @login_with_google_button.
  ///
  /// In en, this message translates to:
  /// **'Log in with Google'**
  String get login_with_google_button;

  /// No description provided for @login_with_passkey_button.
  ///
  /// In en, this message translates to:
  /// **'Log in with Passkey'**
  String get login_with_passkey_button;

  /// No description provided for @map_card_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get map_card_close;

  /// No description provided for @map_card_navigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate me'**
  String get map_card_navigate;

  /// No description provided for @map_categoryFilter_afterParty.
  ///
  /// In en, this message translates to:
  /// **'Afterparty'**
  String get map_categoryFilter_afterParty;

  /// No description provided for @map_categoryFilter_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get map_categoryFilter_all;

  /// No description provided for @map_categoryFilter_bar.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get map_categoryFilter_bar;

  /// No description provided for @map_categoryFilter_beforeParty.
  ///
  /// In en, this message translates to:
  /// **'Before party'**
  String get map_categoryFilter_beforeParty;

  /// No description provided for @map_categoryFilter_cultural.
  ///
  /// In en, this message translates to:
  /// **'Cultural'**
  String get map_categoryFilter_cultural;

  /// No description provided for @map_categoryFilter_event.
  ///
  /// In en, this message translates to:
  /// **'Main Event'**
  String get map_categoryFilter_event;

  /// No description provided for @map_categoryFilter_food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get map_categoryFilter_food;

  /// No description provided for @map_categoryFilter_leanCodeOffice.
  ///
  /// In en, this message translates to:
  /// **'LeanCode'**
  String get map_categoryFilter_leanCodeOffice;

  /// No description provided for @map_categoryFilter_museum.
  ///
  /// In en, this message translates to:
  /// **'Museum'**
  String get map_categoryFilter_museum;

  /// No description provided for @map_categoryFilter_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get map_categoryFilter_other;

  /// No description provided for @map_categoryFilter_park.
  ///
  /// In en, this message translates to:
  /// **'Park'**
  String get map_categoryFilter_park;

  /// No description provided for @map_categoryFilter_sideEvent.
  ///
  /// In en, this message translates to:
  /// **'Side event'**
  String get map_categoryFilter_sideEvent;

  /// No description provided for @map_centerOnUserLocation_semanticsLabel.
  ///
  /// In en, this message translates to:
  /// **'Center on yourself'**
  String get map_centerOnUserLocation_semanticsLabel;

  /// No description provided for @map_locationServiceSnackBar_action.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get map_locationServiceSnackBar_action;

  /// No description provided for @map_locationServiceSnackBar_caption.
  ///
  /// In en, this message translates to:
  /// **'Location service is disabled'**
  String get map_locationServiceSnackBar_caption;

  /// No description provided for @navBar_agenda.
  ///
  /// In en, this message translates to:
  /// **'Agenda'**
  String get navBar_agenda;

  /// No description provided for @navBar_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navBar_home;

  /// No description provided for @navBar_map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get navBar_map;

  /// No description provided for @navBar_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get navBar_notifications;

  /// No description provided for @navBar_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navBar_settings;

  /// No description provided for @notifications_emptyState_message.
  ///
  /// In en, this message translates to:
  /// **'This is where you’ll find all important updates, event info, and alerts.'**
  String get notifications_emptyState_message;

  /// No description provided for @notifications_emptyState_title.
  ///
  /// In en, this message translates to:
  /// **'Nothing to see here… yet'**
  String get notifications_emptyState_title;

  /// No description provided for @notifications_placeholderIcon_semanticsLabel.
  ///
  /// In en, this message translates to:
  /// **'Notification information'**
  String get notifications_placeholderIcon_semanticsLabel;

  /// No description provided for @onboardingPage1_message.
  ///
  /// In en, this message translates to:
  /// **'Join a full day of inspiring tech talks, networking, and innovation in the heart of Warsaw.'**
  String get onboardingPage1_message;

  /// No description provided for @onboardingPage1_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Flutter Tech Summit.'**
  String get onboardingPage1_title;

  /// No description provided for @onboardingPage2_message.
  ///
  /// In en, this message translates to:
  /// **'Explore our lineup of top speakers and share your feedback after each session.'**
  String get onboardingPage2_message;

  /// No description provided for @onboardingPage2_title.
  ///
  /// In en, this message translates to:
  /// **'Meet the speakers.\nRate the talks.'**
  String get onboardingPage2_title;

  /// No description provided for @onboardingPage3_message.
  ///
  /// In en, this message translates to:
  /// **'From the stage to the afterparty — navigate the venue and plan your day with ease.'**
  String get onboardingPage3_message;

  /// No description provided for @onboardingPage3_title.
  ///
  /// In en, this message translates to:
  /// **'Find your way. Don’t miss a thing.'**
  String get onboardingPage3_title;

  /// No description provided for @onboarding_continueToApp.
  ///
  /// In en, this message translates to:
  /// **'Let’s start'**
  String get onboarding_continueToApp;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @passkey_login_no_credentials_available_error.
  ///
  /// In en, this message translates to:
  /// **'No passkey credentials available'**
  String get passkey_login_no_credentials_available_error;

  /// No description provided for @password_field.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_field;

  /// No description provided for @password_field_hide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get password_field_hide;

  /// No description provided for @password_field_show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get password_field_show;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy – FTS Conference App  \nEffective date: May 27, 2025  \n\nThis Privacy Policy describes how your personal data is collected, used, and protected when you use the FTS Conference App (\"App\").  \n\n1. Data Controller  \nThe controller of your personal data is:  \nLeanCode Sp. z o.o.  \nWróbla 8A, 02-736 Warsaw, Poland  \nKRS: 0000638275  \nNIP: 7010616433  \nREGON: 365456272  \nEmail: iod@leancode.pl  \n\n2. Data We Collect  \nYou can use the App without logging in. However, if you choose to register or log in, we may collect the following personal data:  \n- First name and last name  \n- Email address  \n- Consent to the Terms & Conditions and Privacy Policy  \n\nNo additional personal or sensitive data is collected.  \n\n3. Purpose of Data Processing  \nWe collect your data only for the following purposes:  \n- To allow access to features that require registration (e.g. rating conference talks)  \n- To provide core functionality of the App  \n- To send push notifications related to the event (e.g. session reminders)  \n\n4. Push Notifications  \nThe App uses Firebase Cloud Messaging (FCM) to send push notifications. These notifications are the same for all users and are not personalized. You can disable notifications at any time in your device settings.  \n\n5. Analytics and Tracking  \nAt this time, the App does not use analytics or tracking tools. If this changes in the future (e.g. Firebase Analytics is added), this policy will be updated accordingly.  \n\n6. Location Data  \nThe App does not collect your precise location. It may access your general location (e.g. for map functionality) only if you grant permission through the operating system. No location data is stored or shared.  \n\n7. Data Sharing  \nWe do not share your personal data with third parties, except for services necessary to provide app functionality (e.g. Firebase push notification infrastructure). These services act as data processors under appropriate agreements.  \n\n8. Data Storage  \nWe do not store any data locally on your device other than what is required for temporary app operation. All user data is stored securely on our servers.  \n\n9. Data Retention and Deletion  \nYou have the right to request access, correction, or deletion of your personal data. To do so, please contact us at:  \nrodo@leancode.pl  \nUser data will be removed upon request, and in any case not retained longer than necessary for the duration of the event.  \n\n10. Your Rights  \nIn accordance with the GDPR, you have the right to:  \n- Access your personal data  \n- Correct incorrect or outdated information  \n- Request deletion of your data  \n- Object to certain forms of processing  \n\nYou also have the right to lodge a complaint with a supervisory authority.  \n\n11. Changes to This Policy  \nThis Privacy Policy may be updated to reflect changes in legal or operational requirements. Any changes will be published in the App or on the conference website.  \n\nLast updated: May 27, 2025\n'**
  String get privacy_policy;

  /// No description provided for @profile_edit_form.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get profile_edit_form;

  /// No description provided for @profile_email_change_verification.
  ///
  /// In en, this message translates to:
  /// **'Please click on link sent to your email address'**
  String get profile_email_change_verification;

  /// No description provided for @profile_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profile_logout;

  /// No description provided for @profile_my_profile.
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get profile_my_profile;

  /// No description provided for @profile_password_change.
  ///
  /// In en, this message translates to:
  /// **'Password change'**
  String get profile_password_change;

  /// No description provided for @profile_rate_us.
  ///
  /// In en, this message translates to:
  /// **'Give us feedback'**
  String get profile_rate_us;

  /// No description provided for @profile_save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get profile_save_changes;

  /// No description provided for @profile_save_success.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profile_save_success;

  /// No description provided for @quick_action_rate_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please leave us feedback before app deletion'**
  String get quick_action_rate_subtitle;

  /// No description provided for @quick_action_rate_title.
  ///
  /// In en, this message translates to:
  /// **'Something wrong?'**
  String get quick_action_rate_title;

  /// No description provided for @ratePopup_send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get ratePopup_send;

  /// No description provided for @ratePopup_starButtonSemantics.
  ///
  /// In en, this message translates to:
  /// **'{rating} out of {max} stars'**
  String ratePopup_starButtonSemantics({required int rating, required int max});

  /// No description provided for @ratePopup_textFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Tell something more'**
  String get ratePopup_textFieldTitle;

  /// No description provided for @ratePopup_title.
  ///
  /// In en, this message translates to:
  /// **'Rate the talk'**
  String get ratePopup_title;

  /// No description provided for @reauthorize_info.
  ///
  /// In en, this message translates to:
  /// **'To perform this operation you must log in again.'**
  String get reauthorize_info;

  /// No description provided for @reauthorize_info_button.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get reauthorize_info_button;

  /// No description provided for @reauthorize_title.
  ///
  /// In en, this message translates to:
  /// **'Authorization'**
  String get reauthorize_title;

  /// No description provided for @recovery_page_back_button.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get recovery_page_back_button;

  /// No description provided for @recovery_page_code_label.
  ///
  /// In en, this message translates to:
  /// **'Recovery code'**
  String get recovery_page_code_label;

  /// No description provided for @recovery_page_enter_code.
  ///
  /// In en, this message translates to:
  /// **'Enter the recovery code that was sent to your e-mail address'**
  String get recovery_page_enter_code;

  /// No description provided for @recovery_page_enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter the e-mail that you are trying to recover'**
  String get recovery_page_enter_email;

  /// No description provided for @recovery_page_no_code_received.
  ///
  /// In en, this message translates to:
  /// **'No code received?'**
  String get recovery_page_no_code_received;

  /// No description provided for @recovery_page_password_changed.
  ///
  /// In en, this message translates to:
  /// **'Password has been changed'**
  String get recovery_page_password_changed;

  /// No description provided for @recovery_page_pin_title.
  ///
  /// In en, this message translates to:
  /// **'PIN'**
  String get recovery_page_pin_title;

  /// No description provided for @recovery_page_recover.
  ///
  /// In en, this message translates to:
  /// **'Recover'**
  String get recovery_page_recover;

  /// No description provided for @recovery_page_recover_headline.
  ///
  /// In en, this message translates to:
  /// **'Recover your account'**
  String get recovery_page_recover_headline;

  /// No description provided for @recovery_page_send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get recovery_page_send;

  /// No description provided for @recovery_page_title.
  ///
  /// In en, this message translates to:
  /// **'Recovery page'**
  String get recovery_page_title;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get register;

  /// No description provided for @registerPage_alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get registerPage_alreadyHaveAnAccount;

  /// No description provided for @register_family_name_field.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get register_family_name_field;

  /// No description provided for @register_first_name_field.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get register_first_name_field;

  /// No description provided for @register_fts.
  ///
  /// In en, this message translates to:
  /// **'Sign up to FTS'**
  String get register_fts;

  /// No description provided for @register_header.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get register_header;

  /// No description provided for @register_other_methods.
  ///
  /// In en, this message translates to:
  /// **'Or register with'**
  String get register_other_methods;

  /// No description provided for @register_passwordless_label.
  ///
  /// In en, this message translates to:
  /// **'Set up secure passwordless login'**
  String get register_passwordless_label;

  /// No description provided for @register_set_passkey.
  ///
  /// In en, this message translates to:
  /// **'Set passkey'**
  String get register_set_passkey;

  /// No description provided for @register_set_password.
  ///
  /// In en, this message translates to:
  /// **'Set password'**
  String get register_set_password;

  /// No description provided for @register_unknown_error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, try again'**
  String get register_unknown_error;

  /// No description provided for @register_use_password_label.
  ///
  /// In en, this message translates to:
  /// **'Or use password'**
  String get register_use_password_label;

  /// No description provided for @register_with_apple_button.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Apple'**
  String get register_with_apple_button;

  /// No description provided for @register_with_facebook_button.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Facebook'**
  String get register_with_facebook_button;

  /// No description provided for @register_with_google_button.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get register_with_google_button;

  /// No description provided for @register_with_passkey_button.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Passkey'**
  String get register_with_passkey_button;

  /// No description provided for @remove_passkey_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while removing the passkey. Try again.'**
  String get remove_passkey_error;

  /// No description provided for @remove_passkey_success.
  ///
  /// In en, this message translates to:
  /// **'Passkey removed successfully'**
  String get remove_passkey_success;

  /// No description provided for @remove_passkey_title.
  ///
  /// In en, this message translates to:
  /// **'Remove Passkey'**
  String get remove_passkey_title;

  /// No description provided for @resend_button_label.
  ///
  /// In en, this message translates to:
  /// **'Resend the code'**
  String get resend_button_label;

  /// No description provided for @roundTableDetails_badge.
  ///
  /// In en, this message translates to:
  /// **'Table {tableNumber}'**
  String roundTableDetails_badge({required int tableNumber});

  /// No description provided for @roundTableDetails_moderator.
  ///
  /// In en, this message translates to:
  /// **'Moderator'**
  String get roundTableDetails_moderator;

  /// No description provided for @sessionDetails_clockSemanticsLabel.
  ///
  /// In en, this message translates to:
  /// **'Event time'**
  String get sessionDetails_clockSemanticsLabel;

  /// No description provided for @sessionDetails_timeSpan.
  ///
  /// In en, this message translates to:
  /// **'{startDate}, {startHour} – {endHour}'**
  String sessionDetails_timeSpan({
    required DateTime startDate,
    required DateTime startHour,
    required DateTime endHour,
  });

  /// No description provided for @sessionTile_duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get sessionTile_duration;

  /// No description provided for @sessionTile_durationSpan.
  ///
  /// In en, this message translates to:
  /// **'{start} – {end}'**
  String sessionTile_durationSpan({
    required DateTime start,
    required DateTime end,
  });

  /// No description provided for @sessionTile_live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get sessionTile_live;

  /// No description provided for @sessionTile_yourRating.
  ///
  /// In en, this message translates to:
  /// **'Your rating: {stars}/{maxStars}'**
  String sessionTile_yourRating({required int stars, required int maxStars});

  /// No description provided for @settings_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settings_account;

  /// No description provided for @settings_account_changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get settings_account_changePassword;

  /// No description provided for @settings_account_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get settings_account_delete;

  /// No description provided for @settings_account_information.
  ///
  /// In en, this message translates to:
  /// **'My information'**
  String get settings_account_information;

  /// No description provided for @settings_account_loginMethods.
  ///
  /// In en, this message translates to:
  /// **'Login methods'**
  String get settings_account_loginMethods;

  /// No description provided for @settings_account_passkeys.
  ///
  /// In en, this message translates to:
  /// **'Passkeys'**
  String get settings_account_passkeys;

  /// No description provided for @settings_account_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settings_account_profile;

  /// No description provided for @settings_account_security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settings_account_security;

  /// No description provided for @settings_account_twoFactor.
  ///
  /// In en, this message translates to:
  /// **'Two factor authentication'**
  String get settings_account_twoFactor;

  /// No description provided for @settings_agreements.
  ///
  /// In en, this message translates to:
  /// **'Agreements'**
  String get settings_agreements;

  /// No description provided for @settings_appPreferences_header.
  ///
  /// In en, this message translates to:
  /// **'Flutter Tech Summit'**
  String get settings_appPreferences_header;

  /// No description provided for @settings_changePassword_change.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get settings_changePassword_change;

  /// No description provided for @settings_changePassword_new.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get settings_changePassword_new;

  /// No description provided for @settings_chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose the language'**
  String get settings_chooseLanguage;

  /// No description provided for @settings_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get settings_documents;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settings_notifications;

  /// No description provided for @settings_openSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open source licenses'**
  String get settings_openSourceLicenses;

  /// No description provided for @settings_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get settings_other;

  /// No description provided for @settings_preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settings_preferences;

  /// No description provided for @settings_privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settings_privacyPolicy;

  /// No description provided for @settings_rules.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get settings_rules;

  /// No description provided for @settings_signUpTileButton.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get settings_signUpTileButton;

  /// No description provided for @settings_signUpTileMessage.
  ///
  /// In en, this message translates to:
  /// **'To rate sessions, leave feedback, and boost great speakers, you need to have an account.'**
  String get settings_signUpTileMessage;

  /// No description provided for @settings_signUpTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up and rate talks'**
  String get settings_signUpTileTitle;

  /// No description provided for @settings_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// No description provided for @signUpToRateTile_message.
  ///
  /// In en, this message translates to:
  /// **'Rate sessions, leave feedback, and boost great speakers.'**
  String get signUpToRateTile_message;

  /// No description provided for @signUpToRateTile_title.
  ///
  /// In en, this message translates to:
  /// **'Sign up to rate this talk'**
  String get signUpToRateTile_title;

  /// No description provided for @signup_login_button.
  ///
  /// In en, this message translates to:
  /// **'Have an account? Log in'**
  String get signup_login_button;

  /// No description provided for @signup_with_email.
  ///
  /// In en, this message translates to:
  /// **'Sign up with an e-mail'**
  String get signup_with_email;

  /// No description provided for @social_traits_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get social_traits_cancel;

  /// No description provided for @social_traits_unknown_error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, try again'**
  String get social_traits_unknown_error;

  /// No description provided for @speakerDetails_aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get speakerDetails_aboutMe;

  /// No description provided for @speakerDetails_linkedInButtonSemantics.
  ///
  /// In en, this message translates to:
  /// **'Speaker\'s LinkedIn profile'**
  String get speakerDetails_linkedInButtonSemantics;

  /// No description provided for @speakerDetails_moderatorBadge.
  ///
  /// In en, this message translates to:
  /// **'Moderator'**
  String get speakerDetails_moderatorBadge;

  /// No description provided for @speakerDetails_myTables.
  ///
  /// In en, this message translates to:
  /// **'My tables'**
  String get speakerDetails_myTables;

  /// No description provided for @speakerDetails_myTalks.
  ///
  /// In en, this message translates to:
  /// **'My talks'**
  String get speakerDetails_myTalks;

  /// No description provided for @speakerDetails_speakerBadge.
  ///
  /// In en, this message translates to:
  /// **'Speaker'**
  String get speakerDetails_speakerBadge;

  /// No description provided for @splashScreen_by.
  ///
  /// In en, this message translates to:
  /// **'BY'**
  String get splashScreen_by;

  /// No description provided for @splashScreen_mainText.
  ///
  /// In en, this message translates to:
  /// **'Flutter\nTech Summit'**
  String get splashScreen_mainText;

  /// No description provided for @success_verification.
  ///
  /// In en, this message translates to:
  /// **'Success verification'**
  String get success_verification;

  /// No description provided for @suggest_update_dialog_subtitle.
  ///
  /// In en, this message translates to:
  /// **'New version is available, you can download it now'**
  String get suggest_update_dialog_subtitle;

  /// No description provided for @suggest_update_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Update app'**
  String get suggest_update_dialog_title;

  /// No description provided for @suggest_update_dialog_updateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get suggest_update_dialog_updateButton;

  /// No description provided for @talkDetails_speaker.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1 {Speaker} other {Speakers}}'**
  String talkDetails_speaker({required num count});

  /// No description provided for @terms_conditions_checkbox.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get terms_conditions_checkbox;

  /// No description provided for @terms_of_service.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions – FTS Conference App\n\nEffective date: May 27, 2025\n\nThese Terms & Conditions (\"Terms\") govern your use of the FTS Conference App (\"App\"). By using the App, you agree to be bound by these Terms. If you do not agree, please do not use the App.\n\nGeneral Information\n\nThe FTS Conference App is developed and operated by:\n\nLEANCODE Sp. z o.o.  \nWróbla 8A, 02-736 Warsaw, Poland  \nKRS: 0000638275  \nNIP: 7010616433  \nREGON: 365456272  \nContact: office@leancode.pl\n\nPurpose of the App\n\nThe App is intended for participants of the FTS conference. It provides access to the event agenda, session details, speaker profiles, venue information, and optional features such as talk ratings and push notifications.\n\nThe App is offered free of charge and is provided for informational purposes only.\n\nUser Accounts\n\nUsing the App does not require registration. However, users may choose to register with their name and email address to access optional features (e.g. talk ratings).\n\nBy registering, users agree to provide accurate and complete information.\n\nUser Conduct\n\nYou agree to use the App in a lawful and respectful manner. You may not:  \n- Interfere with the normal operation of the App  \n- Attempt to gain unauthorized access to any part of the system  \n- Misrepresent your identity or impersonate others  \n- Violate applicable laws or third-party rights\n\nIntellectual Property\n\nAll content presented in the App (such as schedules, speaker profiles, names, logos, and branding) is the property of its respective owners and is protected by applicable copyright and trademark laws.\n\nYou may not reproduce, distribute, or commercially exploit any part of the App content without prior written consent.\n\nAvailability and Updates\n\nWe aim to provide a stable and reliable service, but we do not guarantee that the App will always be available or error-free. We reserve the right to modify, suspend, or discontinue any part of the App at any time without notice.\n\nWe may release updates that improve functionality, fix bugs, or add new features. It is your responsibility to keep the App updated.\n\nPrivacy and Data Handling\n\nPlease refer to our Privacy Policy for detailed information on how we collect, use, and protect your personal data.\n\nLimitation of Liability\n\nThe App is provided \"as is\" without warranties of any kind. We are not liable for:  \n- Any direct or indirect damages resulting from your use of the App  \n- Temporary or permanent unavailability of the App or its features  \n- Inaccuracies in session times or speaker information  \n\nUse of the App is at your own risk.\n\nGoverning Law\n\nThese Terms shall be governed by and interpreted in accordance with the laws of Poland. Any disputes shall be resolved by the competent courts in Warsaw, Poland.\n\n10. Contact\n\nFor questions regarding these Terms or your use of the App, contact us at:  \noffice@leancode.pl\n\nLast updated: May 27, 2025\n'**
  String get terms_of_service;

  /// No description provided for @validator_consent_required.
  ///
  /// In en, this message translates to:
  /// **'Consent is required'**
  String get validator_consent_required;

  /// No description provided for @validator_email_wrong_format.
  ///
  /// In en, this message translates to:
  /// **'Wrong format of email'**
  String get validator_email_wrong_format;

  /// No description provided for @validator_field_empty.
  ///
  /// In en, this message translates to:
  /// **'Field cannot be empty'**
  String get validator_field_empty;

  /// No description provided for @validator_min_chars_password.
  ///
  /// In en, this message translates to:
  /// **'Passwords need to be at least 8 characters'**
  String get validator_min_chars_password;

  /// No description provided for @validator_passwords_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get validator_passwords_not_match;

  /// No description provided for @verification_code_send_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while sending the code. Try again.'**
  String get verification_code_send_error;

  /// No description provided for @verification_code_send_success.
  ///
  /// In en, this message translates to:
  /// **'Code sent successfully'**
  String get verification_code_send_success;

  /// No description provided for @verification_page_button.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get verification_page_button;

  /// No description provided for @verification_page_field.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verification_page_field;

  /// No description provided for @verification_page_header.
  ///
  /// In en, this message translates to:
  /// **'Enter a verification code'**
  String get verification_page_header;

  /// No description provided for @verification_page_subtitle.
  ///
  /// In en, this message translates to:
  /// **'We have send you an e-mail with a verification code'**
  String get verification_page_subtitle;

  /// No description provided for @verification_page_title.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification_page_title;

  /// No description provided for @verify_expired_button.
  ///
  /// In en, this message translates to:
  /// **'Resend a verification code'**
  String get verify_expired_button;

  /// No description provided for @verify_expired_header.
  ///
  /// In en, this message translates to:
  /// **'Your link has expired'**
  String get verify_expired_header;

  /// No description provided for @verify_expired_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Provide us with your email address, and we will send you a new e-mail with a verification code.'**
  String get verify_expired_subtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
