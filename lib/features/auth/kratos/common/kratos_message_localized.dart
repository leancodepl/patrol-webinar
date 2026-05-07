import 'package:fts/resources/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';
import 'package:timeago/timeago.dart' as timeago;

// English translations based on https://www.ory.sh/docs/kratos/concepts/ui-messages
extension KratosMessageExtension on KratosMessage {
  String localized(AppLocalizations s, String locale) {
    final rootMessageError = UnsupportedError(
      "Messages with codes ending with 00 shouldn't be translated",
    );
    return switch (this) {
      InfoSelfServiceLoginRoot() => throw rootMessageError,
      InfoSelfServiceLogin() => s.kratos_info_self_service_login,
      InfoSelfServiceLoginWith(:final provider) =>
        s.kratos_info_self_service_login_with(provider: provider),
      InfoSelfServiceLoginReAuth() => s.kratos_info_self_service_login_re_auth,
      InfoSelfServiceLoginMFA() => s.kratos_info_self_service_login_mfa,
      InfoSelfServiceLoginVerify() => s.kratos_info_self_service_login_verify,
      InfoSelfServiceLoginTOTPLabel() =>
        s.kratos_info_self_service_login_totp_label,
      InfoLoginLookupLabel() => s.kratos_info_login_lookup_label,
      InfoSelfServiceLoginWebAuthn() =>
        s.kratos_info_self_service_login_web_authn,
      InfoLoginTOTP() => s.kratos_info_login_totp,
      InfoLoginLookup() => s.kratos_info_login_lookup,
      InfoSelfServiceLoginContinueWebAuthn() =>
        s.kratos_info_self_service_login_continue_web_authn,
      InfoSelfServiceLoginWebAuthnPasswordless() =>
        s.kratos_info_self_service_login_web_authn_passwordless,
      InfoSelfServiceLoginContinue() =>
        s.kratos_info_self_service_login_continue,
      InfoSelfServiceEmailHasBeenSent() =>
        s.kratos_info_self_service_email_has_been_sent,
      InfoSelfServiceSignInWithCode() =>
        s.kratos_info_self_service_sign_in_with_code,
      InfoSelfServiceSigningInWillLinkYourAccount(
        :final identifier,
        :final provider,
      ) =>
        s.kratos_info_self_service_signing_in_will_link_your_account(
          duplicateIdentifier: identifier,
          provider: provider,
        ),
      InfoSelfServiceSignInAndLink() =>
        s.kratos_info_self_service_sign_in_and_link,
      InfoSelfserviceSignInAndLinkCredential(:final provider) =>
        s.kratos_info_selfservice_sign_in_and_link_credential(
          provider: provider,
        ),
      InfoSendCodeTo(:final address) => s.kratos_info_send_code_to(
        address: address,
      ),
      InfoSelfServiceLogout() => throw rootMessageError,
      InfoSelfServiceMFA() => throw rootMessageError,
      InfoSelfServiceRegistration() => s.kratos_info_self_service_registration,
      InfoSelfServiceRegistrationWith(:final provider) =>
        s.kratos_info_self_service_registration_with(provider: provider),
      InfoSelfServiceRegistrationContinue() =>
        s.kratos_info_self_service_registration_continue,
      InfoSelfServiceRegistrationRegisterWebAuthn() =>
        s.kratos_info_self_service_registration_register_web_authn,
      InfoSelfServiceRegistrationEmailHasBeenSent() =>
        s.kratos_info_self_service_registration_email_has_been_sent,
      InfoSelfServiceRegistrationRegisterWithCode() =>
        s.kratos_info_self_service_registration_register_with_code,
      InfoSelfServiceRegistrationRoot() => throw rootMessageError,
      InfoSelfServiceSettings() => throw rootMessageError,
      InfoSelfServiceSettingsUpdateSuccess() =>
        s.kratos_info_self_service_settings_update_success,
      InfoSelfServiceSettingsUpdateLinkOidc(:final provider) =>
        s.kratos_info_self_service_settings_update_link_oidc(
          provider: provider,
        ),
      InfoSelfServiceSettingsUpdateUnlinkOidc(:final provider) =>
        s.kratos_info_self_service_settings_update_unlink_oidc(
          provider: provider,
        ),
      InfoSelfServiceSettingsUpdateUnlinkTOTP() =>
        s.kratos_info_self_service_settings_update_unlink_totp,
      InfoSelfServiceSettingsTOTPQRCode() =>
        s.kratos_info_self_service_settings_totp_qrcode,
      InfoSelfServiceSettingsTOTPSecret(:final secret) =>
        s.kratos_info_self_service_settings_totp_secret(secret: secret),
      InfoSelfServiceSettingsRevealLookup() =>
        s.kratos_info_self_service_settings_reveal_lookup,
      InfoSelfServiceSettingsRegenerateLookup() =>
        s.kratos_info_self_service_settings_regenerate_lookup,
      InfoSelfServiceSettingsLookupSecret(:final secret) =>
        s.kratos_info_self_service_settings_lookup_secret(secret: secret),
      InfoSelfServiceSettingsLookupSecretLabel() =>
        s.kratos_info_self_service_settings_lookup_secret_label,
      InfoSelfServiceSettingsLookupConfirm() =>
        s.kratos_info_self_service_settings_lookup_confirm,
      InfoSelfServiceSettingsRegisterWebAuthn() =>
        s.kratos_info_self_service_settings_register_web_authn,
      InfoSelfServiceSettingsRegisterWebAuthnDisplayName() =>
        s.kratos_info_self_service_settings_register_web_authn_display_name,
      InfoSelfServiceSettingsLookupSecretUsed(:final usedAtUnix) =>
        s.kratos_info_self_service_settings_lookup_secret_used(
          usedAt: formatDateTime(usedAtUnix, locale),
        ),
      InfoSelfServiceSettingsLookupSecretList(:final secrets) =>
        s.kratos_info_self_service_settings_lookup_secret_list(
          secretsList: secrets.join(', '),
        ),
      InfoSelfServiceSettingsDisableLookup() =>
        s.kratos_info_self_service_settings_disable_lookup,
      InfoSelfServiceSettingsTOTPSecretLabel() =>
        s.kratos_info_self_service_settings_totp_secret_label,
      InfoSelfServiceSettingsRemoveWebAuthn(:final displayName) =>
        s.kratos_info_self_service_settings_remove_web_authn(
          displayName: displayName,
        ),
      InfoSelfServiceSettingsRemovePasskey(:final displayName) =>
        s.kratos_info_self_service_settings_remove_passkey(
          displayName: displayName,
        ),
      InfoSelfServiceRecovery() => throw rootMessageError,
      InfoSelfServiceRecoverySuccessful() =>
        s.kratos_info_self_service_recovery_successful,
      InfoSelfServiceRecoveryEmailSent() =>
        s.kratos_info_self_service_recovery_email_sent,
      InfoSelfServiceRecoveryEmailWithCodeSent() =>
        s.kratos_info_self_service_recovery_email_with_code_sent,
      InfoNodeLabel() => throw rootMessageError,
      InfoNodeLabelInputPassword() => s.kratos_info_node_label_input_password,
      InfoNodeLabelGenerated(:final title) =>
        s.kratos_info_node_label_generated(title: title),
      InfoNodeLabelSave() => s.kratos_info_node_label_save,
      InfoNodeLabelID() => s.kratos_info_node_label_id,
      InfoNodeLabelSubmit() => s.kratos_info_node_label_submit,
      InfoNodeLabelVerifyOTP() => s.kratos_info_node_label_verify_otp,
      InfoNodeLabelEmail() => s.kratos_info_node_label_email,
      InfoNodeLabelResendOTP() => s.kratos_info_node_label_resend_otp,
      InfoNodeLabelContinue() => s.kratos_info_node_label_continue,
      InfoNodeLabelRecoveryCode() => s.kratos_info_node_label_recovery_code,
      InfoNodeLabelVerificationCode() =>
        s.kratos_info_node_label_verification_code,
      InfoNodeLabelRegistrationCode() =>
        s.kratos_info_node_label_registration_code,
      InfoNodeLabelLoginCode() => s.kratos_info_node_label_login_code,
      InfoNodeLabelLoginAndLinkCredential() =>
        s.kratos_info_node_label_login_and_link_credential,
      InfoSelfServiceVerification() => throw rootMessageError,
      InfoSelfServiceVerificationEmailSent() =>
        s.kratos_info_self_service_verification_email_sent,
      InfoSelfServiceVerificationSuccessful() =>
        s.kratos_info_self_service_verification_successful,
      InfoSelfServiceVerificationEmailWithCodeSent() =>
        s.kratos_info_self_service_verification_email_with_code_sent,
      ErrorValidation() => throw rootMessageError,
      ErrorValidationGeneric(:final reason) =>
        s.kratos_error_validation_generic(reason: reason),
      ErrorValidationRequired(:final property) =>
        s.kratos_error_validation_required(property: property),
      ErrorValidationMinLength(:final minimum, :final actual) =>
        s.kratos_error_validation_min_length(minimum: minimum, actual: actual),
      ErrorValidationInvalidFormat(:final pattern) =>
        s.kratos_error_validation_invalid_format(pattern: pattern),
      ErrorValidationPasswordPolicyViolation(:final reason) =>
        s.kratos_error_validation_password_policy_violation(reason: reason),
      ErrorValidationInvalidCredentials() =>
        s.kratos_error_validation_invalid_credentials,
      ErrorValidationDuplicateCredentials() =>
        s.kratos_error_validation_duplicate_credentials,
      ErrorValidationTOTPVerifierWrong() =>
        s.kratos_error_validation_totp_verifier_wrong,
      ErrorValidationIdentifierMissing() =>
        s.kratos_error_validation_identifier_missing,
      ErrorValidationAddressNotVerified() =>
        s.kratos_error_validation_address_not_verified,
      ErrorValidationNoTOTPDevice() => s.kratos_error_validation_no_totp_device,
      ErrorValidationLookupAlreadyUsed() =>
        s.kratos_error_validation_lookup_already_used,
      ErrorValidationNoWebAuthnDevice() =>
        s.kratos_error_validation_no_web_authn_device,
      ErrorValidationNoLookup() => s.kratos_error_validation_no_lookup,
      ErrorValidationSuchNoWebAuthnUser() =>
        s.kratos_error_validation_such_no_web_authn_user,
      ErrorValidationLookupInvalid() =>
        s.kratos_error_validation_lookup_invalid,
      ErrorValidationMaxLength(:final maxLength, :final actualLength) =>
        s.kratos_error_validation_max_length(
          maxLength: maxLength,
          actualLength: actualLength,
        ),
      ErrorValidationMinimum(:final minimum, :final actual) =>
        s.kratos_error_validation_min_length(minimum: minimum, actual: actual),
      ErrorValidationExclusiveMinimum(:final minimum, :final actual) =>
        s.kratos_error_validation_min_length(minimum: minimum, actual: actual),
      ErrorValidationMaximum(:final maximum, :final actual) =>
        s.kratos_error_validation_max_length(
          maxLength: maximum,
          actualLength: actual,
        ),
      ErrorValidationExclusiveMaximum(:final maximum, :final actual) =>
        s.kratos_error_validation_max_length(
          maxLength: maximum,
          actualLength: actual,
        ),
      ErrorValidationMultipleOf(:final actual, :final base) =>
        s.kratos_error_validation_multiple_of(actual: actual, base: base),
      ErrorValidationMaxItems(:final maxItems, :final actualItems) =>
        s.kratos_error_validation_max_items(
          maxItems: maxItems,
          actualItems: actualItems,
        ),
      ErrorValidationMinItems(:final minItems, :final actualItems) =>
        s.kratos_error_validation_min_items(
          minItems: minItems,
          actualItems: actualItems,
        ),
      ErrorValidationUniqueItems(:final indexA, :final indexB) =>
        s.kratos_error_validation_unique_items(indexA: indexA, indexB: indexB),
      ErrorValidationWrongType(:final actualType, :final allowedTypesList) =>
        s.kratos_error_validation_wrong_type(
          allowedTypesList: allowedTypesList.join(', '),
          actualType: actualType,
        ),
      ErrorValidationDuplicateCredentialsOnOIDCLink() =>
        s.kratos_error_validation_duplicate_credentials_on_oidc_link,
      ErrorValidationCredentialAlreadyUsedByAnotherAccount(
        :final credentialIdentifierHint,
        :final availableCredentialTypesList,
      ) =>
        s.kratos_error_validation_credential_already_used_by_another_account(
          credentialIdentifierHint: credentialIdentifierHint,
          availableCredentialTypesList: availableCredentialTypesList.join(', '),
        ),
      ErrorValidationMustBeEqualToConstant(:final expected) =>
        s.kratos_error_validation_must_be_equal_to_constant(expected: expected),
      ErrorValidationConstFailed() => s.kratos_error_validation_const_failed,
      ErrorValidationPasswordTooSimilarToIdentifier() =>
        s.kratos_error_validation_password_too_similar_to_identifier,
      ErrorValidationPasswordTooShort(:final actualLength, :final minLength) =>
        s.kratos_error_validation_password_too_short(
          minLength: minLength,
          actualLength: actualLength,
        ),
      ErrorValidationPasswordTooLong(:final actualLength, :final maxLength) =>
        s.kratos_error_validation_password_too_long(
          maxLength: maxLength,
          actualLength: actualLength,
        ),
      ErrorValidationPasswordFoundInDataBreaches() =>
        s.kratos_error_validation_password_found_in_data_breaches,
      ErrorValidationNoAccountOrNoCodeSignInSetUp() =>
        s.kratos_error_validation_no_account_or_no_code_sign_in_set_up,
      ErrorValidationTraitsDontMatchPreviouslyAssociated() =>
        s.kratos_error_validation_traits_dont_match_previously_associated,
      ErrorValidationLogin() => throw rootMessageError,
      ErrorValidationLoginFlowExpired(:final expiredAtUnix) =>
        s.kratos_error_validation_login_flow_expired(
          timeAgo: timeAgoString(expiredAtUnix, locale),
        ),
      ErrorValidationLoginNoStrategyFound() =>
        s.kratos_error_validation_login_no_strategy_found,
      ErrorValidationRegistrationNoStrategyFound() =>
        s.kratos_error_validation_registration_no_strategy_found,
      ErrorValidationSettingsNoStrategyFound() =>
        s.kratos_error_validation_settings_no_strategy_found,
      ErrorValidationRecoveryNoStrategyFound() =>
        s.kratos_error_validation_recovery_no_strategy_found,
      ErrorValidationVerificationNoStrategyFound() =>
        s.kratos_error_validation_verification_no_strategy_found,
      ErrorValidationLoginRequestAlreadyCompleted() =>
        s.kratos_error_validation_login_request_already_completed,
      ErrorValidationLoginCodeInvalidOrAlreadyUsed() =>
        s.kratos_error_validation_login_code_invalid_or_already_used,
      ErrorValidationLinkedCredentialsDoNotMatch() =>
        s.kratos_error_validation_linked_credentials_do_not_match,
      ErrorValidationRegistration() => throw rootMessageError,
      ErrorValidationRegistrationFlowExpired(:final expiredAtUnix) =>
        s.kratos_error_validation_registration_flow_expired(
          timeAgo: timeAgoString(expiredAtUnix, locale),
        ),
      ErrorValidationRegistrationRequestAlreadyCompleted() =>
        s.kratos_error_validation_registration_request_already_completed,
      ErrorValidationRegistrationCodeInvalidOrAlreadyUsed() =>
        s.kratos_error_validation_registration_code_invalid_or_already_used,
      ErrorValidationSettings() => throw rootMessageError,
      ErrorValidationSettingsFlowExpired(:final expiredAtUnix) =>
        s.kratos_error_validation_settings_flow_expired(
          timeAgo: timeAgoString(expiredAtUnix, locale),
        ),
      ErrorValidationRecovery() => throw rootMessageError,
      ErrorValidationRecoveryRetrySuccess() =>
        s.kratos_error_validation_recovery_retry_success,
      ErrorValidationRecoveryStateFailure() =>
        s.kratos_error_validation_recovery_state_failure,
      ErrorValidationRecoveryMissingRecoveryToken() =>
        s.kratos_error_validation_recovery_state_failure,
      ErrorValidationRecoveryTokenInvalidOrAlreadyUsed() =>
        s.kratos_error_validation_recovery_token_invalid_or_already_used,
      ErrorValidationRecoveryFlowExpired(:final expiredAtUnix) =>
        s.kratos_error_validation_recovery_flow_expired(
          timeAgo: timeAgoString(expiredAtUnix, locale),
        ),
      ErrorValidationRecoveryCodeInvalidOrAlreadyUsed() =>
        s.kratos_error_validation_recovery_code_invalid_or_already_used,
      ErrorValidationVerification() => throw rootMessageError,
      ErrorValidationVerificationTokenInvalidOrAlreadyUsed() =>
        s.kratos_error_validation_verification_token_invalid_or_already_used,
      ErrorValidationVerificationRetrySuccess() =>
        s.kratos_error_validation_verification_retry_success,
      ErrorValidationVerificationStateFailure() =>
        s.kratos_error_validation_verification_state_failure,
      ErrorValidationVerificationMissingVerificationToken() =>
        s.kratos_error_validation_verification_missing_verification_token,
      ErrorValidationVerificationFlowExpired(:final expiredAtUnix) =>
        s.kratos_error_validation_verification_flow_expired(
          timeAgo: timeAgoString(expiredAtUnix, locale),
        ),
      ErrorValidationVerificationCodeInvalidOrAlreadyUsed() =>
        s.kratos_error_validation_verification_code_invalid_or_already_used,
      ErrorSystemGeneric() => s.kratos_error_system_generic,
      ErrorSystem() => throw UnimplementedError(),
    };
  }
}

String timeAgoString(int unixTimestamp, String locale) {
  final timestamp = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
  return timeago.format(timestamp, locale: locale);
}

String formatDateTime(int unixTimestamp, String locale) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
  return DateFormat.yMMMMd(locale).add_Hm().format(dateTime);
}
