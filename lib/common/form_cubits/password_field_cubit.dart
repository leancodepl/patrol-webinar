import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:leancode_forms/leancode_forms.dart';

class PasswordFieldCubit extends FieldCubit<String, List<ValidationError>> {
  PasswordFieldCubit({
    super.initialValue = '',
    this.minLength = 8,
    this.numberRequired = false,
    this.specialCharRequired = false,
    this.upperCaseRequired = false,
    this.lowerCaseRequired = false,
  }) : super(
         validator: (value) {
           final errors = [
             if (value.isEmpty)
               const LocalValidationError(LocalValidationErrorType.empty),
             if (value.length < minLength)
               const LocalValidationError(LocalValidationErrorType.tooShort),
           ];

           return errors.isEmpty ? null : errors;
         },
       );

  final int minLength;
  final bool numberRequired;
  final bool specialCharRequired;
  final bool upperCaseRequired;
  final bool lowerCaseRequired;
}
