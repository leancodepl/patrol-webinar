import 'package:fts/features/auth/kratos/common/kratos_message_localized.dart';
import 'package:fts/resources/l10n/app_localizations.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

sealed class ValidationError {
  const ValidationError();

  String localized(AppLocalizations s, String locale) {
    return switch (this) {
      LocalValidationError(:final type) => type.localized(s),
      KratosValidationError(:final error) => error.localized(s, locale),
    };
  }
}

class LocalValidationError extends ValidationError {
  const LocalValidationError(this.type);

  final LocalValidationErrorType type;
}

class KratosValidationError extends ValidationError {
  const KratosValidationError(this.error);

  final KratosMessage error;
}

enum LocalValidationErrorType {
  empty,
  tooShort,
  doesNotMatch,
  invalidEmail,
  consentRequired;

  String localized(AppLocalizations s) {
    return switch (this) {
      LocalValidationErrorType.empty => s.validator_field_empty,
      LocalValidationErrorType.tooShort => s.validator_min_chars_password,
      LocalValidationErrorType.doesNotMatch => s.validator_passwords_not_match,
      LocalValidationErrorType.invalidEmail => s.validator_email_wrong_format,
      LocalValidationErrorType.consentRequired => s.validator_consent_required,
    };
  }
}
