import 'package:fts/common/form_cubits/password_field_cubit.dart';
import 'package:leancode_forms/leancode_forms.dart';

class ReauthorizeFormCubit extends FormGroupCubit {
  ReauthorizeFormCubit() {
    registerFields([password]);
  }

  final password = PasswordFieldCubit();
}
