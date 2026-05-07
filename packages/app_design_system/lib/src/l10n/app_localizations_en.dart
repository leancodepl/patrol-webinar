import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppDesignSystemLocalizationsEn extends AppDesignSystemLocalizations {
  AppDesignSystemLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String navigationBar_tabOfTotal(int index, int total) {
    return 'Tab $index of $total';
  }

  @override
  String switch_optionOfTotal(int index, int total) {
    return 'Option $index of $total';
  }

  @override
  String get contextMenu_barrierDismissal => 'Dismiss';

  @override
  String get contextMenuItem_containsMoreItems => '(contains more items)';

  @override
  String get textInput_clear => 'Clear';

  @override
  String get textInput_help => 'Help';

  @override
  String get topBar_menu => 'Menu';

  @override
  String get topBar_back => 'Back';

  @override
  String get snackbar_close => 'Close';

  @override
  String get banner_close => 'Close';

  @override
  String button_loadingSuffix(String semanticsLabel) {
    return '$semanticsLabel (loading)';
  }

  @override
  String get button_loading => 'loading';

  @override
  String appStepProgress_defaultValueBuilder(int numerator, int denominator) {
    return '$numerator/$denominator';
  }

  @override
  String get chip_remove => 'Remove';

  @override
  String get field_required => 'Required field';
}
