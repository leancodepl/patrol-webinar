import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/resources/strings.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({super.key, required this.documentType});

  final DocumentType documentType;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppScaffold.widgets(
      topBar: const AppTopBar(),
      children: [
        AppText(
          documentType.getTitle(context),
          style: AppTextStyles.headlineLarge,
          color: colors.foregroundDefaultPrimary,
        ),
        AppSpacings.s24.verticalSpace,
        AppText(
          documentType.getContent(context),
          style: AppTextStyles.bodyDefault,
          color: colors.foregroundDefaultPrimary,
        ),
      ],
    );
  }
}

enum DocumentType {
  privacyPolicy,
  termsOfService;

  String getContent(BuildContext context) {
    final s = l10n(context);

    return switch (this) {
      privacyPolicy => s.privacy_policy,
      termsOfService => s.terms_of_service,
    };
  }

  String getTitle(BuildContext context) {
    final s = l10n(context);

    return switch (this) {
      privacyPolicy => s.settings_privacyPolicy,
      termsOfService => s.settings_rules,
    };
  }
}
