// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get add_passkey_error =>
      'An error occurred while adding the passkey. Try again.';

  @override
  String get add_passkey_success => 'Passkey added successfully';

  @override
  String get add_passkey_title => 'Add Passkey';

  @override
  String get agenda_title => 'Agenda';

  @override
  String get app_error_view_retry_button => 'Retry';

  @override
  String get app_error_view_subtitle => 'Try again later';

  @override
  String get app_error_view_title => 'Something went wrong';

  @override
  String get common_app_name => 'Flutter Tech Summit';

  @override
  String get common_back => 'Back';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get common_close => 'Close';

  @override
  String get common_error => 'Error';

  @override
  String get common_menu => 'Menu';

  @override
  String get common_rateTalkButton => 'Rate this talk';

  @override
  String get common_save => 'Save';

  @override
  String get common_sortAscending => 'Ascending';

  @override
  String get common_sortDescending => 'Descending';

  @override
  String common_speakerLongDescription({
    required String jobTitle,
    required String companyName,
  }) {
    return '$jobTitle, $companyName';
  }

  @override
  String get connectivityBanner_connectionRestored =>
      'Server connection restored';

  @override
  String get connectivityBanner_connectionUnavailable =>
      'Server connection lost';

  @override
  String get continue_registration => 'Continue';

  @override
  String get delete_account_cancelButton => 'Cancel';

  @override
  String get delete_account_confirmButton => 'Confirm';

  @override
  String get delete_account_error =>
      'An error occurred while deleting your account, please try again.';

  @override
  String get delete_account_subtitle =>
      'Are you sure you want to delete your account?';

  @override
  String get delete_account_success =>
      'Your account has been successfully deleted';

  @override
  String get delete_account_title => 'Delete account';

  @override
  String get email_field => 'E-mail';

  @override
  String get enter_code_email => 'Enter the code from e-mail';

  @override
  String get errorState_message => 'Something went wrong, please try again';

  @override
  String get errorState_title => 'Oops!';

  @override
  String get errorState_tryAgain => 'Try again';

  @override
  String get error_handling_authorization => 'No permission, go back';

  @override
  String get error_handling_network =>
      'No internet connection, try again later';

  @override
  String get error_handling_unknown => 'Something went wrong, try again';

  @override
  String get error_verification => 'Error during verification';

  @override
  String get force_update_screen_subtitle =>
      'New version is available, download it to continue';

  @override
  String get force_update_screen_title => 'Update app';

  @override
  String get force_update_screen_updateButton => 'Update';

  @override
  String get forgot_password_button => 'Forgot your password?';

  @override
  String get home_brandingTileDate => 'Warsaw, 5th June';

  @override
  String get home_brandingTileSubtitle =>
      'The only tech event for mobile executives';

  @override
  String get home_brandingTileTitle => 'FLUTTER TECH SUMMIT';

  @override
  String get home_fullAgenda => 'Full agenda';

  @override
  String get home_moderatorsCarouselTitle => 'Meet the moderators';

  @override
  String get home_speakersCarouselTitle => 'Meet the speakers';

  @override
  String get home_title => 'Home';

  @override
  String get home_whatsNext => 'What\'s next';

  @override
  String get identities_title => 'Identities';

  @override
  String get kratos_error_system => 'System error';

  @override
  String get kratos_error_system_generic => 'Generic error';

  @override
  String get kratos_error_validation_address_not_verified =>
      'Account not active yet. Did you forget to verify your email address?';

  @override
  String get kratos_error_validation_const_failed => 'Const failed';

  @override
  String kratos_error_validation_credential_already_used_by_another_account({
    required String credentialIdentifierHint,
    required String availableCredentialTypesList,
  }) {
    return 'Credentials $credentialIdentifierHint already used by another account. Try sign in using $availableCredentialTypesList, or use social sign in providers';
  }

  @override
  String get kratos_error_validation_duplicate_credentials =>
      'An account with this login information already exists';

  @override
  String get kratos_error_validation_duplicate_credentials_on_oidc_link =>
      'An account with the same identifier exists already';

  @override
  String kratos_error_validation_exclusive_maximum({
    required int maximum,
    required int actual,
  }) {
    return 'Must be < $maximum but found $actual';
  }

  @override
  String kratos_error_validation_exclusive_minimum({
    required int minimum,
    required int actual,
  }) {
    return 'Must be > $minimum but found $actual';
  }

  @override
  String kratos_error_validation_generic({required String reason}) {
    return '$reason';
  }

  @override
  String get kratos_error_validation_identifier_missing =>
      'Could not find any login identifiers. Did you forget to set them? This could also be caused by a server misconfiguration';

  @override
  String get kratos_error_validation_invalid_credentials =>
      'Invalid email address or password';

  @override
  String kratos_error_validation_invalid_format({required String pattern}) {
    return 'Does not match pattern \"$pattern\"';
  }

  @override
  String get kratos_error_validation_linked_credentials_do_not_match =>
      'Credentials do not match';

  @override
  String get kratos_error_validation_login_code_invalid_or_already_used =>
      'Login code invalid or used';

  @override
  String kratos_error_validation_login_flow_expired({required String timeAgo}) {
    return 'The login flow expired $timeAgo, please try again.';
  }

  @override
  String get kratos_error_validation_login_no_strategy_found =>
      'Could not find a strategy to log you in with. Did you fill out the form correctly?';

  @override
  String get kratos_error_validation_login_request_already_completed =>
      'Request already completed';

  @override
  String get kratos_error_validation_lookup_already_used =>
      'The recovery code has already been redeemed';

  @override
  String get kratos_error_validation_lookup_invalid =>
      'The backup recovery code is not valid';

  @override
  String kratos_error_validation_max_items({
    required int maxItems,
    required int actualItems,
  }) {
    return 'Maximum $maxItems items allowed, but found $actualItems items';
  }

  @override
  String kratos_error_validation_max_length({
    required int maxLength,
    required int actualLength,
  }) {
    return 'Length must be <= $maxLength, but got $actualLength';
  }

  @override
  String kratos_error_validation_maximum({
    required int maximum,
    required int actual,
  }) {
    return 'Must be <= $maximum but found $actual';
  }

  @override
  String kratos_error_validation_min_items({
    required int minItems,
    required int actualItems,
  }) {
    return 'Minimum $minItems items allowed, but found $actualItems items';
  }

  @override
  String kratos_error_validation_min_length({
    required int minimum,
    required int actual,
  }) {
    return 'Must be >= $minimum but found $actual';
  }

  @override
  String kratos_error_validation_multiple_of({
    required int actual,
    required int base,
  }) {
    return '$actual not multipleOf $base';
  }

  @override
  String kratos_error_validation_must_be_equal_to_constant({
    required String expected,
  }) {
    return 'Must be equal to constant: $expected';
  }

  @override
  String get kratos_error_validation_no_account_or_no_code_sign_in_set_up =>
      'No account or no code sign in set up';

  @override
  String get kratos_error_validation_no_lookup =>
      'You have no backup recovery codes set up';

  @override
  String get kratos_error_validation_no_totp_device =>
      'You have no TOTP device set up';

  @override
  String get kratos_error_validation_no_web_authn_device =>
      'You have no WebAuthn device set up';

  @override
  String get kratos_error_validation_password_found_in_data_breaches =>
      'Password found in data breaches';

  @override
  String kratos_error_validation_password_policy_violation({
    required String reason,
  }) {
    return 'The password can not be used because $reason';
  }

  @override
  String kratos_error_validation_password_too_long({
    required int maxLength,
    required int actualLength,
  }) {
    return 'Password too long, must have at most $maxLength characters, but got $actualLength';
  }

  @override
  String kratos_error_validation_password_too_short({
    required int minLength,
    required int actualLength,
  }) {
    return 'Password too short, must have at least $minLength characters, but got $actualLength';
  }

  @override
  String get kratos_error_validation_password_too_similar_to_identifier =>
      'Password too similar to identifier';

  @override
  String get kratos_error_validation_recovery_code_invalid_or_already_used =>
      'The recovery code is invalid or has already been used';

  @override
  String kratos_error_validation_recovery_flow_expired({
    required String timeAgo,
  }) {
    return 'The recovery flow expired $timeAgo, please try again';
  }

  @override
  String get kratos_error_validation_recovery_no_strategy_found =>
      'Could not find a strategy to recover your account with. Did you fill out the form correctly?';

  @override
  String get kratos_error_validation_recovery_retry_success =>
      'The request has already been sent successfully and cannot be repeated';

  @override
  String get kratos_error_validation_recovery_state_failure =>
      'The recovery flow reached a failure state and must be retried';

  @override
  String get kratos_error_validation_recovery_token_invalid_or_already_used =>
      'The code is invalid or has already been used';

  @override
  String
  get kratos_error_validation_registration_code_invalid_or_already_used =>
      'Registration code invalid or used';

  @override
  String kratos_error_validation_registration_flow_expired({
    required String timeAgo,
  }) {
    return 'The registration flow expired $timeAgo, please try again.';
  }

  @override
  String get kratos_error_validation_registration_no_strategy_found =>
      'Could not find a strategy to sign you up with. Did you fill out the form correctly?';

  @override
  String get kratos_error_validation_registration_request_already_completed =>
      'Request already completed';

  @override
  String kratos_error_validation_required({required String property}) {
    return 'Property $property is missing';
  }

  @override
  String kratos_error_validation_settings_flow_expired({
    required String timeAgo,
  }) {
    return 'The settings flow expired $timeAgo, please try again';
  }

  @override
  String get kratos_error_validation_settings_no_strategy_found =>
      'Could not find a strategy to update your settings. Did you fill out the form correctly?';

  @override
  String get kratos_error_validation_such_no_web_authn_user =>
      'This account does not exist or has no security key set up';

  @override
  String get kratos_error_validation_totp_verifier_wrong =>
      'The verification code you entered is invalid';

  @override
  String get kratos_error_validation_traits_dont_match_previously_associated =>
      'Traits don\'t match previously associated';

  @override
  String kratos_error_validation_unique_items({
    required int indexA,
    required int indexB,
  }) {
    return 'Items at index $indexA and $indexB are equal';
  }

  @override
  String
  get kratos_error_validation_verification_code_invalid_or_already_used =>
      'The verification code is invalid or has already been used. Try again';

  @override
  String kratos_error_validation_verification_flow_expired({
    required String timeAgo,
  }) {
    return 'The verification flow expired $timeAgo, please try again';
  }

  @override
  String get kratos_error_validation_verification_missing_verification_token =>
      'The verification token is missing, please provide a valid token';

  @override
  String get kratos_error_validation_verification_no_strategy_found =>
      'Could not find a strategy to verify your account with. Did you fill out the form correctly?';

  @override
  String get kratos_error_validation_verification_retry_success =>
      'The request was already completed successfully and can not be retried';

  @override
  String get kratos_error_validation_verification_state_failure =>
      'The verification flow reached a failure state and must be retried';

  @override
  String
  get kratos_error_validation_verification_token_invalid_or_already_used =>
      'The code is invalid or has already been used';

  @override
  String kratos_error_validation_wrong_type({
    required String allowedTypesList,
    required String actualType,
  }) {
    return 'Expected $allowedTypesList, but got $actualType';
  }

  @override
  String get kratos_info_login_lookup => 'Use backup recovery code';

  @override
  String get kratos_info_login_lookup_label => 'Backup recovery code';

  @override
  String get kratos_info_login_totp => 'Use Authenticator';

  @override
  String get kratos_info_node_label_continue => 'Continue';

  @override
  String get kratos_info_node_label_email => 'Email';

  @override
  String kratos_info_node_label_generated({required String title}) {
    return '$title';
  }

  @override
  String get kratos_info_node_label_id => 'ID';

  @override
  String get kratos_info_node_label_input_password => 'Password';

  @override
  String get kratos_info_node_label_login_and_link_credential =>
      'Log in and link credential';

  @override
  String get kratos_info_node_label_login_code => 'Login code';

  @override
  String get kratos_info_node_label_recovery_code => 'Recovery code';

  @override
  String get kratos_info_node_label_registration_code => 'Registration code';

  @override
  String get kratos_info_node_label_resend_otp => 'Resend code';

  @override
  String get kratos_info_node_label_save => 'Save';

  @override
  String get kratos_info_node_label_submit => 'Submit';

  @override
  String get kratos_info_node_label_verification_code => 'Verification code';

  @override
  String get kratos_info_node_label_verify_otp => 'Verify code';

  @override
  String get kratos_info_self_service_email_has_been_sent =>
      'Email has been sent';

  @override
  String get kratos_info_self_service_login => 'Sign in';

  @override
  String get kratos_info_self_service_login_continue => 'Continue';

  @override
  String get kratos_info_self_service_login_continue_web_authn =>
      'Continue with security key';

  @override
  String get kratos_info_self_service_login_mfa =>
      'Please complete the second authentication challenge';

  @override
  String get kratos_info_self_service_login_re_auth =>
      'Please confirm this action by verifying that it is you';

  @override
  String get kratos_info_self_service_login_totp_label => 'Authentication code';

  @override
  String get kratos_info_self_service_login_verify => 'Verify';

  @override
  String get kratos_info_self_service_login_web_authn => 'Use security key';

  @override
  String get kratos_info_self_service_login_web_authn_passwordless =>
      'Prepare your WebAuthn device (e.g. security key, biometrics scanner, ...) and press continue.';

  @override
  String kratos_info_self_service_login_with({required String provider}) {
    return 'Sign in with $provider';
  }

  @override
  String get kratos_info_self_service_recovery_email_sent =>
      'We have sent you an email with a link to reset your password to the email address you provided.';

  @override
  String get kratos_info_self_service_recovery_email_with_code_sent =>
      'We have sent an email containing a recovery code to the email address you provided.';

  @override
  String get kratos_info_self_service_recovery_successful =>
      'Account recovered successfully. Please change your password or set up an alternative login method.';

  @override
  String get kratos_info_self_service_registration => 'Sign up';

  @override
  String get kratos_info_self_service_registration_continue => 'Continue';

  @override
  String get kratos_info_self_service_registration_email_has_been_sent =>
      'Email has been sent';

  @override
  String get kratos_info_self_service_registration_register_web_authn =>
      'Sign up with security key';

  @override
  String get kratos_info_self_service_registration_register_with_code =>
      'Register with code';

  @override
  String kratos_info_self_service_registration_with({
    required String provider,
  }) {
    return 'Sign up with $provider';
  }

  @override
  String get kratos_info_self_service_settings_disable_lookup =>
      'Disable this method';

  @override
  String get kratos_info_self_service_settings_lookup_confirm =>
      'Confirm backup recovery codes';

  @override
  String kratos_info_self_service_settings_lookup_secret({
    required String secret,
  }) {
    return '$secret';
  }

  @override
  String get kratos_info_self_service_settings_lookup_secret_label =>
      'These are your back up recovery codes. Keep them in safe place, and use it if you can not scan the QR code.';

  @override
  String kratos_info_self_service_settings_lookup_secret_list({
    required String secretsList,
  }) {
    return '$secretsList';
  }

  @override
  String kratos_info_self_service_settings_lookup_secret_used({
    required String usedAt,
  }) {
    return 'Secret was used at $usedAt';
  }

  @override
  String get kratos_info_self_service_settings_regenerate_lookup =>
      'Generate new backup recovery codes';

  @override
  String get kratos_info_self_service_settings_register_web_authn =>
      'Add security key';

  @override
  String
  get kratos_info_self_service_settings_register_web_authn_display_name =>
      'Name of the security key';

  @override
  String kratos_info_self_service_settings_remove_passkey({
    required String displayName,
  }) {
    return 'Remove passkey \"$displayName\"';
  }

  @override
  String kratos_info_self_service_settings_remove_web_authn({
    required String displayName,
  }) {
    return 'Remove security key \"$displayName\"';
  }

  @override
  String get kratos_info_self_service_settings_reveal_lookup =>
      'Reveal backup recovery codes';

  @override
  String get kratos_info_self_service_settings_totp_qrcode =>
      'Authenticator app QR code';

  @override
  String kratos_info_self_service_settings_totp_secret({
    required String secret,
  }) {
    return '$secret';
  }

  @override
  String get kratos_info_self_service_settings_totp_secret_label =>
      'This is your authenticator app secret. Use it if you can not scan the QR code';

  @override
  String kratos_info_self_service_settings_update_link_oidc({
    required String provider,
  }) {
    return 'Link $provider';
  }

  @override
  String get kratos_info_self_service_settings_update_success =>
      'Your changes have been saved!';

  @override
  String kratos_info_self_service_settings_update_unlink_oidc({
    required String provider,
  }) {
    return 'Unlink $provider';
  }

  @override
  String get kratos_info_self_service_settings_update_unlink_totp =>
      'Unlink TOTP Authenticator App';

  @override
  String get kratos_info_self_service_sign_in_and_link => 'Sign in and link';

  @override
  String get kratos_info_self_service_sign_in_with_code => 'Sign in with code';

  @override
  String kratos_info_self_service_signing_in_will_link_your_account({
    required String duplicateIdentifier,
    required String provider,
  }) {
    return '$duplicateIdentifier is already linked. Sign in with \"$provider\" to connect accounts';
  }

  @override
  String get kratos_info_self_service_verification_email_sent =>
      'An email with a verification link has been sent to the address you provided';

  @override
  String get kratos_info_self_service_verification_email_with_code_sent =>
      'An email with a verification code has been sent to the address you provided';

  @override
  String get kratos_info_self_service_verification_successful =>
      'Your email address has been confirmed';

  @override
  String kratos_info_selfservice_sign_in_and_link_credential({
    required String provider,
  }) {
    return 'Confirm with $provider';
  }

  @override
  String kratos_info_send_code_to({required String address}) {
    return 'Send code to $address';
  }

  @override
  String get languageSelector_hint =>
      'Tap the button to open a language selection menu';

  @override
  String get languageSelector_label => 'Currently selected language is ';

  @override
  String get languageSelector_openMenu => 'Open language selection menu';

  @override
  String get languageSelector_selected => 'Currently selected language';

  @override
  String get loginPage_title => 'Log in to FTS';

  @override
  String get login_button => 'Log in';

  @override
  String get login_header => 'Log in';

  @override
  String get login_login_method_not_added_to_account_message =>
      'This login method has not been added to your account. Please log in using another method';

  @override
  String get login_no_account_caption => 'Don\'t have an account?';

  @override
  String get login_page_recovery_button => 'I forgot my password';

  @override
  String get login_signup_button => 'Don\'t have an account? Sign up';

  @override
  String get login_social_caption => 'Or continue with';

  @override
  String get login_unknown_error => 'Something went wrong, try again';

  @override
  String get login_verify_account_button => 'Resend code';

  @override
  String login_verify_account_button_timed({required String value}) {
    return 'Resend code | $value';
  }

  @override
  String get login_verify_account_header =>
      'To log in you need to verify your email';

  @override
  String get login_verify_account_resend_button =>
      'Didn\'t get the code? Send again';

  @override
  String get login_verify_account_subtitle =>
      'You can click on a verification link sent in the previous email or send it again using the button below';

  @override
  String get login_with_apple_button => 'Log in with Apple';

  @override
  String get login_with_email => 'Log in with an e-mail';

  @override
  String get login_with_facebook_button => 'Log in with Facebook';

  @override
  String get login_with_google_button => 'Log in with Google';

  @override
  String get login_with_passkey_button => 'Log in with Passkey';

  @override
  String get map_card_close => 'Close';

  @override
  String get map_card_navigate => 'Navigate me';

  @override
  String get map_categoryFilter_afterParty => 'Afterparty';

  @override
  String get map_categoryFilter_all => 'All';

  @override
  String get map_categoryFilter_bar => 'Bar';

  @override
  String get map_categoryFilter_beforeParty => 'Before party';

  @override
  String get map_categoryFilter_cultural => 'Cultural';

  @override
  String get map_categoryFilter_event => 'Main Event';

  @override
  String get map_categoryFilter_food => 'Food';

  @override
  String get map_categoryFilter_leanCodeOffice => 'LeanCode';

  @override
  String get map_categoryFilter_museum => 'Museum';

  @override
  String get map_categoryFilter_other => 'Other';

  @override
  String get map_categoryFilter_park => 'Park';

  @override
  String get map_categoryFilter_sideEvent => 'Side event';

  @override
  String get map_centerOnUserLocation_semanticsLabel => 'Center on yourself';

  @override
  String get map_locationServiceSnackBar_action => 'Enable';

  @override
  String get map_locationServiceSnackBar_caption =>
      'Location service is disabled';

  @override
  String get navBar_agenda => 'Agenda';

  @override
  String get navBar_home => 'Home';

  @override
  String get navBar_map => 'Map';

  @override
  String get navBar_notifications => 'Notifications';

  @override
  String get navBar_settings => 'Settings';

  @override
  String get notifications_emptyState_message =>
      'This is where you’ll find all important updates, event info, and alerts.';

  @override
  String get notifications_emptyState_title => 'Nothing to see here… yet';

  @override
  String get notifications_placeholderIcon_semanticsLabel =>
      'Notification information';

  @override
  String get onboardingPage1_message =>
      'Join a full day of inspiring tech talks, networking, and innovation in the heart of Warsaw.';

  @override
  String get onboardingPage1_title => 'Welcome to Flutter Tech Summit.';

  @override
  String get onboardingPage2_message =>
      'Explore our lineup of top speakers and share your feedback after each session.';

  @override
  String get onboardingPage2_title => 'Meet the speakers.\nRate the talks.';

  @override
  String get onboardingPage3_message =>
      'From the stage to the afterparty — navigate the venue and plan your day with ease.';

  @override
  String get onboardingPage3_title => 'Find your way. Don’t miss a thing.';

  @override
  String get onboarding_continueToApp => 'Let’s start';

  @override
  String get or => 'or';

  @override
  String get passkey_login_no_credentials_available_error =>
      'No passkey credentials available';

  @override
  String get password_field => 'Password';

  @override
  String get password_field_hide => 'Hide';

  @override
  String get password_field_show => 'Show';

  @override
  String get privacy_policy =>
      'Privacy Policy – FTS Conference App  \nEffective date: May 27, 2025  \n\nThis Privacy Policy describes how your personal data is collected, used, and protected when you use the FTS Conference App (\"App\").  \n\n1. Data Controller  \nThe controller of your personal data is:  \nLeanCode Sp. z o.o.  \nWróbla 8A, 02-736 Warsaw, Poland  \nKRS: 0000638275  \nNIP: 7010616433  \nREGON: 365456272  \nEmail: iod@leancode.pl  \n\n2. Data We Collect  \nYou can use the App without logging in. However, if you choose to register or log in, we may collect the following personal data:  \n- First name and last name  \n- Email address  \n- Consent to the Terms & Conditions and Privacy Policy  \n\nNo additional personal or sensitive data is collected.  \n\n3. Purpose of Data Processing  \nWe collect your data only for the following purposes:  \n- To allow access to features that require registration (e.g. rating conference talks)  \n- To provide core functionality of the App  \n- To send push notifications related to the event (e.g. session reminders)  \n\n4. Push Notifications  \nThe App uses Firebase Cloud Messaging (FCM) to send push notifications. These notifications are the same for all users and are not personalized. You can disable notifications at any time in your device settings.  \n\n5. Analytics and Tracking  \nAt this time, the App does not use analytics or tracking tools. If this changes in the future (e.g. Firebase Analytics is added), this policy will be updated accordingly.  \n\n6. Location Data  \nThe App does not collect your precise location. It may access your general location (e.g. for map functionality) only if you grant permission through the operating system. No location data is stored or shared.  \n\n7. Data Sharing  \nWe do not share your personal data with third parties, except for services necessary to provide app functionality (e.g. Firebase push notification infrastructure). These services act as data processors under appropriate agreements.  \n\n8. Data Storage  \nWe do not store any data locally on your device other than what is required for temporary app operation. All user data is stored securely on our servers.  \n\n9. Data Retention and Deletion  \nYou have the right to request access, correction, or deletion of your personal data. To do so, please contact us at:  \nrodo@leancode.pl  \nUser data will be removed upon request, and in any case not retained longer than necessary for the duration of the event.  \n\n10. Your Rights  \nIn accordance with the GDPR, you have the right to:  \n- Access your personal data  \n- Correct incorrect or outdated information  \n- Request deletion of your data  \n- Object to certain forms of processing  \n\nYou also have the right to lodge a complaint with a supervisory authority.  \n\n11. Changes to This Policy  \nThis Privacy Policy may be updated to reflect changes in legal or operational requirements. Any changes will be published in the App or on the conference website.  \n\nLast updated: May 27, 2025\n';

  @override
  String get profile_edit_form => 'Edit';

  @override
  String get profile_email_change_verification =>
      'Please click on link sent to your email address';

  @override
  String get profile_logout => 'Logout';

  @override
  String get profile_my_profile => 'My profile';

  @override
  String get profile_password_change => 'Password change';

  @override
  String get profile_rate_us => 'Give us feedback';

  @override
  String get profile_save_changes => 'Save';

  @override
  String get profile_save_success => 'Profile updated';

  @override
  String get quick_action_rate_subtitle =>
      'Please leave us feedback before app deletion';

  @override
  String get quick_action_rate_title => 'Something wrong?';

  @override
  String get ratePopup_send => 'Send';

  @override
  String ratePopup_starButtonSemantics({
    required int rating,
    required int max,
  }) {
    return '$rating out of $max stars';
  }

  @override
  String get ratePopup_textFieldTitle => 'Tell something more';

  @override
  String get ratePopup_title => 'Rate the talk';

  @override
  String get reauthorize_info =>
      'To perform this operation you must log in again.';

  @override
  String get reauthorize_info_button => 'Next';

  @override
  String get reauthorize_title => 'Authorization';

  @override
  String get recovery_page_back_button => 'Back';

  @override
  String get recovery_page_code_label => 'Recovery code';

  @override
  String get recovery_page_enter_code =>
      'Enter the recovery code that was sent to your e-mail address';

  @override
  String get recovery_page_enter_email =>
      'Enter the e-mail that you are trying to recover';

  @override
  String get recovery_page_no_code_received => 'No code received?';

  @override
  String get recovery_page_password_changed => 'Password has been changed';

  @override
  String get recovery_page_pin_title => 'PIN';

  @override
  String get recovery_page_recover => 'Recover';

  @override
  String get recovery_page_recover_headline => 'Recover your account';

  @override
  String get recovery_page_send => 'Send';

  @override
  String get recovery_page_title => 'Recovery page';

  @override
  String get register => 'Sign up';

  @override
  String get registerPage_alreadyHaveAnAccount => 'Already have an account?';

  @override
  String get register_family_name_field => 'Last name';

  @override
  String get register_first_name_field => 'First name';

  @override
  String get register_fts => 'Sign up to FTS';

  @override
  String get register_header => 'Sign up';

  @override
  String get register_other_methods => 'Or register with';

  @override
  String get register_passwordless_label => 'Set up secure passwordless login';

  @override
  String get register_set_passkey => 'Set passkey';

  @override
  String get register_set_password => 'Set password';

  @override
  String get register_unknown_error => 'Something went wrong, try again';

  @override
  String get register_use_password_label => 'Or use password';

  @override
  String get register_with_apple_button => 'Sign up with Apple';

  @override
  String get register_with_facebook_button => 'Sign up with Facebook';

  @override
  String get register_with_google_button => 'Sign up with Google';

  @override
  String get register_with_passkey_button => 'Sign up with Passkey';

  @override
  String get remove_passkey_error =>
      'An error occurred while removing the passkey. Try again.';

  @override
  String get remove_passkey_success => 'Passkey removed successfully';

  @override
  String get remove_passkey_title => 'Remove Passkey';

  @override
  String get resend_button_label => 'Resend the code';

  @override
  String roundTableDetails_badge({required int tableNumber}) {
    return 'Table $tableNumber';
  }

  @override
  String get roundTableDetails_moderator => 'Moderator';

  @override
  String get sessionDetails_clockSemanticsLabel => 'Event time';

  @override
  String sessionDetails_timeSpan({
    required DateTime startDate,
    required DateTime startHour,
    required DateTime endHour,
  }) {
    final intl.DateFormat startDateDateFormat = intl.DateFormat.MMMEd(
      localeName,
    );
    final String startDateString = startDateDateFormat.format(startDate);
    final intl.DateFormat startHourDateFormat = intl.DateFormat.Hm(localeName);
    final String startHourString = startHourDateFormat.format(startHour);
    final intl.DateFormat endHourDateFormat = intl.DateFormat.Hm(localeName);
    final String endHourString = endHourDateFormat.format(endHour);

    return '$startDateString, $startHourString – $endHourString';
  }

  @override
  String get sessionTile_duration => 'Duration';

  @override
  String sessionTile_durationSpan({
    required DateTime start,
    required DateTime end,
  }) {
    final intl.DateFormat startDateFormat = intl.DateFormat.Hm(localeName);
    final String startString = startDateFormat.format(start);
    final intl.DateFormat endDateFormat = intl.DateFormat.Hm(localeName);
    final String endString = endDateFormat.format(end);

    return '$startString – $endString';
  }

  @override
  String get sessionTile_live => 'Live';

  @override
  String sessionTile_yourRating({required int stars, required int maxStars}) {
    return 'Your rating: $stars/$maxStars';
  }

  @override
  String get settings_account => 'Account';

  @override
  String get settings_account_changePassword => 'Change password';

  @override
  String get settings_account_delete => 'Delete account';

  @override
  String get settings_account_information => 'My information';

  @override
  String get settings_account_loginMethods => 'Login methods';

  @override
  String get settings_account_passkeys => 'Passkeys';

  @override
  String get settings_account_profile => 'Profile';

  @override
  String get settings_account_security => 'Security';

  @override
  String get settings_account_twoFactor => 'Two factor authentication';

  @override
  String get settings_agreements => 'Agreements';

  @override
  String get settings_appPreferences_header => 'Flutter Tech Summit';

  @override
  String get settings_changePassword_change => 'Change password';

  @override
  String get settings_changePassword_new => 'New password';

  @override
  String get settings_chooseLanguage => 'Choose the language';

  @override
  String get settings_documents => 'Documents';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_notifications => 'Notifications';

  @override
  String get settings_openSourceLicenses => 'Open source licenses';

  @override
  String get settings_other => 'Other';

  @override
  String get settings_preferences => 'Preferences';

  @override
  String get settings_privacyPolicy => 'Privacy policy';

  @override
  String get settings_rules => 'Terms of service';

  @override
  String get settings_signUpTileButton => 'Sign up';

  @override
  String get settings_signUpTileMessage =>
      'To rate sessions, leave feedback, and boost great speakers, you need to have an account.';

  @override
  String get settings_signUpTileTitle => 'Sign up and rate talks';

  @override
  String get settings_theme => 'Theme';

  @override
  String get signUpToRateTile_message =>
      'Rate sessions, leave feedback, and boost great speakers.';

  @override
  String get signUpToRateTile_title => 'Sign up to rate this talk';

  @override
  String get signup_login_button => 'Have an account? Log in';

  @override
  String get signup_with_email => 'Sign up with an e-mail';

  @override
  String get social_traits_cancel => 'Cancel';

  @override
  String get social_traits_unknown_error => 'Something went wrong, try again';

  @override
  String get speakerDetails_aboutMe => 'About me';

  @override
  String get speakerDetails_linkedInButtonSemantics =>
      'Speaker\'s LinkedIn profile';

  @override
  String get speakerDetails_moderatorBadge => 'Moderator';

  @override
  String get speakerDetails_myTables => 'My tables';

  @override
  String get speakerDetails_myTalks => 'My talks';

  @override
  String get speakerDetails_speakerBadge => 'Speaker';

  @override
  String get splashScreen_by => 'BY';

  @override
  String get splashScreen_mainText => 'Flutter\nTech Summit';

  @override
  String get success_verification => 'Success verification';

  @override
  String get suggest_update_dialog_subtitle =>
      'New version is available, you can download it now';

  @override
  String get suggest_update_dialog_title => 'Update app';

  @override
  String get suggest_update_dialog_updateButton => 'Update';

  @override
  String talkDetails_speaker({required num count}) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Speakers',
      one: 'Speaker',
    );
    return '$_temp0';
  }

  @override
  String get terms_conditions_checkbox => 'I agree to the';

  @override
  String get terms_of_service =>
      'Terms & Conditions – FTS Conference App\n\nEffective date: May 27, 2025\n\nThese Terms & Conditions (\"Terms\") govern your use of the FTS Conference App (\"App\"). By using the App, you agree to be bound by these Terms. If you do not agree, please do not use the App.\n\nGeneral Information\n\nThe FTS Conference App is developed and operated by:\n\nLEANCODE Sp. z o.o.  \nWróbla 8A, 02-736 Warsaw, Poland  \nKRS: 0000638275  \nNIP: 7010616433  \nREGON: 365456272  \nContact: office@leancode.pl\n\nPurpose of the App\n\nThe App is intended for participants of the FTS conference. It provides access to the event agenda, session details, speaker profiles, venue information, and optional features such as talk ratings and push notifications.\n\nThe App is offered free of charge and is provided for informational purposes only.\n\nUser Accounts\n\nUsing the App does not require registration. However, users may choose to register with their name and email address to access optional features (e.g. talk ratings).\n\nBy registering, users agree to provide accurate and complete information.\n\nUser Conduct\n\nYou agree to use the App in a lawful and respectful manner. You may not:  \n- Interfere with the normal operation of the App  \n- Attempt to gain unauthorized access to any part of the system  \n- Misrepresent your identity or impersonate others  \n- Violate applicable laws or third-party rights\n\nIntellectual Property\n\nAll content presented in the App (such as schedules, speaker profiles, names, logos, and branding) is the property of its respective owners and is protected by applicable copyright and trademark laws.\n\nYou may not reproduce, distribute, or commercially exploit any part of the App content without prior written consent.\n\nAvailability and Updates\n\nWe aim to provide a stable and reliable service, but we do not guarantee that the App will always be available or error-free. We reserve the right to modify, suspend, or discontinue any part of the App at any time without notice.\n\nWe may release updates that improve functionality, fix bugs, or add new features. It is your responsibility to keep the App updated.\n\nPrivacy and Data Handling\n\nPlease refer to our Privacy Policy for detailed information on how we collect, use, and protect your personal data.\n\nLimitation of Liability\n\nThe App is provided \"as is\" without warranties of any kind. We are not liable for:  \n- Any direct or indirect damages resulting from your use of the App  \n- Temporary or permanent unavailability of the App or its features  \n- Inaccuracies in session times or speaker information  \n\nUse of the App is at your own risk.\n\nGoverning Law\n\nThese Terms shall be governed by and interpreted in accordance with the laws of Poland. Any disputes shall be resolved by the competent courts in Warsaw, Poland.\n\n10. Contact\n\nFor questions regarding these Terms or your use of the App, contact us at:  \noffice@leancode.pl\n\nLast updated: May 27, 2025\n';

  @override
  String get validator_consent_required => 'Consent is required';

  @override
  String get validator_email_wrong_format => 'Wrong format of email';

  @override
  String get validator_field_empty => 'Field cannot be empty';

  @override
  String get validator_min_chars_password =>
      'Passwords need to be at least 8 characters';

  @override
  String get validator_passwords_not_match => 'Passwords don\'t match';

  @override
  String get verification_code_send_error =>
      'An error occurred while sending the code. Try again.';

  @override
  String get verification_code_send_success => 'Code sent successfully';

  @override
  String get verification_page_button => 'Continue';

  @override
  String get verification_page_field => 'Verification code';

  @override
  String get verification_page_header => 'Enter a verification code';

  @override
  String get verification_page_subtitle =>
      'We have send you an e-mail with a verification code';

  @override
  String get verification_page_title => 'Verification';

  @override
  String get verify_expired_button => 'Resend a verification code';

  @override
  String get verify_expired_header => 'Your link has expired';

  @override
  String get verify_expired_subtitle =>
      'Provide us with your email address, and we will send you a new e-mail with a verification code.';
}
