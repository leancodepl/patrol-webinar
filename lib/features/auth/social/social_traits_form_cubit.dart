import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:fts/features/auth/kratos/common/validators.dart';
import 'package:leancode_forms/leancode_forms.dart';

class SocialTraitsFormCubit extends FormGroupCubit {
  SocialTraitsFormCubit() {
    registerFields([email, firstName, lastName, checkbox]);
  }

  final email = TextFieldCubit<ValidationError>(
    validator:
        filled(const LocalValidationError(LocalValidationErrorType.empty)) &
        emailValid(
          const LocalValidationError(LocalValidationErrorType.invalidEmail),
        ),
  );

  final firstName = TextFieldCubit<ValidationError>(
    validator: filled(
      const LocalValidationError(LocalValidationErrorType.empty),
    ),
  );

  final lastName = TextFieldCubit<ValidationError>(
    validator: filled(
      const LocalValidationError(LocalValidationErrorType.empty),
    ),
  );

  final checkbox = BooleanFieldCubit<ValidationError>(
    validator: isTrue(
      const LocalValidationError(LocalValidationErrorType.consentRequired),
    ),
  );

  void setInitialValues({
    required String? emailValue,
    required String? firstNameValue,
    required String? lastNameValue,
    required bool? regulationsAccepted,
  }) {
    email.setValue(emailValue ?? '');
    firstName.setValue(firstNameValue ?? '');
    lastName.setValue(lastNameValue ?? '');
    checkbox.setValue(regulationsAccepted ?? false);
  }
}
