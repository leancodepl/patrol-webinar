import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppDesignSystemLocalizationsPl extends AppDesignSystemLocalizations {
  AppDesignSystemLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String navigationBar_tabOfTotal(int index, int total) {
    return 'Karta $index z $total';
  }

  @override
  String switch_optionOfTotal(int index, int total) {
    return 'Opcja $index z $total';
  }

  @override
  String get contextMenu_barrierDismissal => 'Zamknij';

  @override
  String get contextMenuItem_containsMoreItems => '(zawiera więcej opcji)';

  @override
  String get textInput_clear => 'Wyczyść tekst';

  @override
  String get textInput_help => 'Pomoc';

  @override
  String get topBar_menu => 'Menu';

  @override
  String get topBar_back => 'Wstecz';

  @override
  String get snackbar_close => 'Zamknij';

  @override
  String get banner_close => 'Zamknij';

  @override
  String button_loadingSuffix(String semanticsLabel) {
    return '$semanticsLabel (ładowanie)';
  }

  @override
  String get button_loading => 'ładowanie';

  @override
  String appStepProgress_defaultValueBuilder(int numerator, int denominator) {
    return '$numerator/$denominator';
  }

  @override
  String get chip_remove => 'Usuń';

  @override
  String get field_required => 'Wymagane pole';
}
