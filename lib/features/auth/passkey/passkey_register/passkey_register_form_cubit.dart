import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:fts/features/auth/kratos/common/validators.dart';
import 'package:leancode_forms/leancode_forms.dart';

class PasskeyRegisterFormCubit extends FormGroupCubit {
  PasskeyRegisterFormCubit() {
    registerFields([email, checkbox, firstName, lastName]);
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
}
