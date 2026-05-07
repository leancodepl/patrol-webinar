import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/common/hooks/use_effective_text_controller.dart';
import 'package:fts/common/util/let.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_forms/leancode_forms.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class AppTextFormField<E extends Object> extends FieldBuilder<String, E> {
  AppTextFormField({
    super.key,
    String? label,
    String? hint,
    AppStandardIconData? leadingIcon,
    TextAlign textAlign = TextAlign.start,
    TextEditingController? controller,
    required TextFieldCubit<E> super.field,
    required ErrorTranslator<E> translateError,
    bool obscureText = false,
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
             final textEditingController = useEffectiveTextEditingController(
               controller,
               text: field.state.value,
             );

             useEffect(() {
               if (field.state.value.isNotEmpty) {
                 textEditingController.value = textEditingController.value
                     .copyWith(text: state.value);
                 return null;
               } else {
                 textEditingController.clear();
               }
               return null;
             }, [state.value]);

             return AppTextField(
               decoration: AppTextFieldDecoration(
                 hint: hint,
                 error: state.error?.let(translateError),
                 label: label,
                 leadingIcon: leadingIcon,
               ),
               textAlign: textAlign,
               controller: textEditingController,
               obscureText: obscureText,
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
