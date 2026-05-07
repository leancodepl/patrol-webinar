import 'package:flutter/widgets.dart';
import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:fts/features/settings/document_page.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_forms/leancode_forms.dart';

class TermsConditionsCheckbox extends StatelessWidget {
  const TermsConditionsCheckbox({
    super.key,
    this.checkboxBodyKey,
    required this.field,
  });

  final Key? checkboxBodyKey;
  final BooleanFieldCubit<ValidationError> field;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final colors = context.colors;

    final locale = Localizations.localeOf(context).toLanguageTag();

    return AppCheckboxFormField.customTitle(
      checkboxBodyKey: checkboxBodyKey,
      labelBuilder: (context, color) => AppText.rich(
        [
          AppTextSpan(text: s.terms_conditions_checkbox),
          AppTextSpan(text: ' '),
          AppTextSpan(
            text: s.settings_rules.toLowerCase(),
            color: colors.backgroundInfoPrimary,
            onTap: () => const DocumentRoute(
              DocumentType.termsOfService,
            ).push<void>(context),
          ),
        ],
        style: AppTextStyles.bodyDefault,
        color: color,
      ),
      field: field,
      translateError: (error) => error.localized(s, locale),
    );
  }
}
