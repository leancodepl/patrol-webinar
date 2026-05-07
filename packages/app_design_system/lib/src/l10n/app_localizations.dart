import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppDesignSystemLocalizations
/// returned by `AppDesignSystemLocalizations.of(context)`.
///
/// Applications need to include `AppDesignSystemLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppDesignSystemLocalizations.localizationsDelegates,
///   supportedLocales: AppDesignSystemLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppDesignSystemLocalizations.supportedLocales
/// property.
abstract class AppDesignSystemLocalizations {
  AppDesignSystemLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppDesignSystemLocalizations of(BuildContext context) {
    return Localizations.of<AppDesignSystemLocalizations>(
      context,
      AppDesignSystemLocalizations,
    )!;
  }

  static const LocalizationsDelegate<AppDesignSystemLocalizations> delegate =
      _AppDesignSystemLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @navigationBar_tabOfTotal.
  ///
  /// In en, this message translates to:
  /// **'Tab {index} of {total}'**
  String navigationBar_tabOfTotal(int index, int total);

  /// No description provided for @switch_optionOfTotal.
  ///
  /// In en, this message translates to:
  /// **'Option {index} of {total}'**
  String switch_optionOfTotal(int index, int total);

  /// No description provided for @contextMenu_barrierDismissal.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get contextMenu_barrierDismissal;

  /// No description provided for @contextMenuItem_containsMoreItems.
  ///
  /// In en, this message translates to:
  /// **'(contains more items)'**
  String get contextMenuItem_containsMoreItems;

  /// No description provided for @textInput_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get textInput_clear;

  /// No description provided for @textInput_help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get textInput_help;

  /// No description provided for @topBar_menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get topBar_menu;

  /// No description provided for @topBar_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get topBar_back;

  /// No description provided for @snackbar_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get snackbar_close;

  /// No description provided for @banner_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get banner_close;

  /// No description provided for @button_loadingSuffix.
  ///
  /// In en, this message translates to:
  /// **'{semanticsLabel} (loading)'**
  String button_loadingSuffix(String semanticsLabel);

  /// No description provided for @button_loading.
  ///
  /// In en, this message translates to:
  /// **'loading'**
  String get button_loading;

  /// No description provided for @appStepProgress_defaultValueBuilder.
  ///
  /// In en, this message translates to:
  /// **'{numerator}/{denominator}'**
  String appStepProgress_defaultValueBuilder(int numerator, int denominator);

  /// No description provided for @chip_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get chip_remove;

  /// No description provided for @field_required.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get field_required;
}

class _AppDesignSystemLocalizationsDelegate
    extends LocalizationsDelegate<AppDesignSystemLocalizations> {
  const _AppDesignSystemLocalizationsDelegate();

  @override
  Future<AppDesignSystemLocalizations> load(Locale locale) {
    return SynchronousFuture<AppDesignSystemLocalizations>(
      lookupAppDesignSystemLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppDesignSystemLocalizationsDelegate old) => false;
}

AppDesignSystemLocalizations lookupAppDesignSystemLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppDesignSystemLocalizationsEn();
    case 'pl':
      return AppDesignSystemLocalizationsPl();
  }

  throw FlutterError(
    'AppDesignSystemLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
