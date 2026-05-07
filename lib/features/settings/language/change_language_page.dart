import 'package:flutter/material.dart';
import 'package:fts/features/connectivity/connectivity_app_top_bar.dart';
import 'package:fts/features/localization/localization_notifier.dart';
import 'package:fts/resources/l10n/app_localizations.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:locale_names/locale_names.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    const locales = AppLocalizations.supportedLocales;
    final selectedLocale = context.watch<LocalizationNotifier>().currentLocale;

    return AppScaffold.widgetBuilder(
      topBar: ConnectivityAppTopBar(
        title: s.settings_chooseLanguage,
        centerTitle: false,
      ),
      itemCount: locales.length,
      builder: (context, index) {
        final locale = locales[index];
        return AppRadioTile(
          onChanged: (locale) {
            context.read<LocalizationNotifier>().updateLocale(locale);
          },
          label: locale.nativeDisplayLanguageScript,
          description: locale.displayLanguageScriptIn(
            Localizations.localeOf(context),
          ),
          radioValue: locale,
          radioGroupValue: selectedLocale,
        );
      },
      separatorBuilder: (_, _) => AppSpacings.s16.verticalSpace,
    );
  }
}
