import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/common/form_cubits/password_field_cubit.dart';
import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:fts/common/util/let.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_forms/leancode_forms.dart';

class AppPasswordFormField extends FieldBuilder<String, List<ValidationError>> {
  AppPasswordFormField({
    super.key,
    String? label,
    String? hint,
    AppStandardIconData? leadingIcon,
    TextAlign textAlign = TextAlign.start,
    TextEditingController? controller,
    required PasswordFieldCubit super.field,
    required ErrorTranslator<List<ValidationError>> translateError,
    bool autocorrect = true,
    bool enableSuggestions = true,
    Iterable<String> autofillHints = const [],
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    ValueChanged<String>? onSubmitted,
    bool enabled = true,
  }) : super(
         builder: (context, state) => HookBuilder(
           builder: (context) {
             final s = l10n(context);
             final obscured = useState(true);

             return AppTextField(
               decoration: AppTextFieldDecoration(
                 hint: hint,
                 error: state.error?.let(translateError),
                 label: label,
                 action: AppTextFieldAction(
                   label: obscured.value
                       ? s.password_field_show
                       : s.password_field_hide,
                   onTap: () => obscured.value = !obscured.value,
                   icon: obscured.value
                       ? AppStandardIcons.eye
                       : AppStandardIcons.eyeOff,
                 ),
                 leadingIcon: leadingIcon,
               ),
               textAlign: textAlign,
               controller: controller,
               obscureText: obscured.value,
               autocorrect: autocorrect,
               enableSuggestions: enableSuggestions,
               autofillHints: autofillHints,
               textInputAction: textInputAction,
               textCapitalization: textCapitalization,
               keyboardType: keyboardType,
               onSubmitted: onSubmitted,
               enabled: enabled,
               onChanged: field.getValueSetter(),
             );
           },
         ),
       );
}
