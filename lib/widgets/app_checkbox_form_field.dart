import 'package:flutter/widgets.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_forms/leancode_forms.dart';

class AppCheckboxFormField<E extends Object> extends FieldBuilder<bool?, E> {
  AppCheckboxFormField({
    super.key,
    required String label,
    required BooleanFieldCubit<E> super.field,
    required ErrorTranslator<E> translateError,
    bool enabled = true,
  }) : super(
         builder: (context, state) {
           return AppCheckboxField(
             label: label,
             enabled: enabled,
             error: switch (state.error) {
               final error? => translateError(error),
               null => null,
             },
             checkboxValue: state.value ?? false,
             onChanged: field.setValue,
           );
         },
       );

  AppCheckboxFormField.customTitle({
    super.key,
    Key? checkboxBodyKey,
    required LabelBuilder labelBuilder,
    required BooleanFieldCubit<E> super.field,
    required ErrorTranslator<E> translateError,
    bool enabled = true,
  }) : super(
         builder: (context, state) {
           return AppCheckboxField.customTitle(
             checkboxBodyKey: checkboxBodyKey,
             labelBuilder: labelBuilder,
             enabled: enabled,
             error: switch (state.error) {
               final error? => translateError(error),
               null => null,
             },
             checkboxValue: state.value ?? false,
             onChanged: field.setValue,
           );
         },
       );
}
