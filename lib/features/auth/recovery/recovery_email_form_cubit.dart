import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:fts/features/auth/kratos/common/validators.dart';
import 'package:leancode_forms/leancode_forms.dart';

class RecoveryEmailFormCubit extends FormGroupCubit {
  RecoveryEmailFormCubit() {
    registerFields([email]);
  }

  final email = TextFieldCubit(
    validator:
        filled(const LocalValidationError(LocalValidationErrorType.empty)) &
        emailValid(
          const LocalValidationError(LocalValidationErrorType.invalidEmail),
        ),
  );
}
