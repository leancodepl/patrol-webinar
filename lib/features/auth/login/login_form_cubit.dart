import 'package:fts/common/form_cubits/password_field_cubit.dart';
import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:fts/features/auth/kratos/common/validators.dart';
import 'package:leancode_forms/leancode_forms.dart';

class LoginFormCubit extends FormGroupCubit {
  LoginFormCubit() {
    registerFields([email, password]);
  }

  final email = TextFieldCubit<ValidationError>(
    validator:
        filled(const LocalValidationError(LocalValidationErrorType.empty)) &
        emailValid(
          const LocalValidationError(LocalValidationErrorType.invalidEmail),
        ),
  );

  final password = PasswordFieldCubit();
}
