import 'package:email_validator/email_validator.dart';
import 'package:fts/common/form_cubits/password_field_cubit.dart';
import 'package:leancode_forms/leancode_forms.dart';

Validator<bool, E> isTrue<E extends Object>(E message) => (value) {
  if (!value) {
    return message;
  }

  return null;
};

Validator<String?, E> emailValid<E extends Object>(E message) => (value) {
  if (value == null) {
    return null;
  }
  if (!EmailValidator.validate(value)) {
    return message;
  }
  return null;
};

Validator<String?, E> exactlySamePassword<E extends Object>(
  PasswordFieldCubit passwordCubit,
  E message,
) => (value) {
  if (value != passwordCubit.state.value) {
    return message;
  }

  return null;
};
