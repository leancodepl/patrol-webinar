import 'package:flutter/material.dart';
import 'package:fts/resources/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class LocalizationNotifier extends ChangeNotifier {
  late Locale _locale = _normalizeLocale(
    Intl.defaultLocale ?? Intl.systemLocale,
  );
  Locale get currentLocale => _locale;

  void updateLocale(Locale? l) {
    if (l != null) {
      _locale = l;
      notifyListeners();
    }
  }

  Locale _normalizeLocale(String localeString) {
    final locale = Locale(localeString.split('_')[0]);
    return AppLocalizations.supportedLocales.contains(locale)
        ? locale
        : AppLocalizations.supportedLocales.first;
  }
}
