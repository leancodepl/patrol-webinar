import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/features/localization/localization_notifier.dart';
import 'package:fts/resources/assets.gen.dart';
import 'package:fts/resources/l10n/app_localizations.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:provider/provider.dart';

const double _popupMenuWidth = 105;
const double _borderRadius = 6;
const double _flagWidth = 16;
const double _flagHeight = 12;

final _flagPaths = {'pl': Assets.flags.plFlag, 'en': Assets.flags.ukFlag};

class LanguageSelector extends HookWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final isMenuOpened = useState(false);
    final currentLocale = context.watch<LocalizationNotifier>().currentLocale;
    final s = l10n(context);
    return Semantics(
      label: '${s.languageSelector_label} ${currentLocale.languageCode}',
      hint: s.languageSelector_hint,
      child: PopupMenuButton<Locale>(
        initialValue: currentLocale,
        constraints: const BoxConstraints(
          maxWidth: _popupMenuWidth,
          minWidth: _popupMenuWidth,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(_borderRadius),
            bottomRight: Radius.circular(_borderRadius),
          ),
        ),
        menuPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        position: PopupMenuPosition.under,
        itemBuilder: (context) {
          return [
            PopupMenuItem<Locale>(
              enabled: false,
              padding: EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(_borderRadius),
                    bottomRight: Radius.circular(_borderRadius),
                  ),
                  color: context.colors.backgroundDefaultPrimary,
                  border: const Border(
                    left: BorderSide(),
                    right: BorderSide(),
                    bottom: BorderSide(),
                  ),
                ),
                child: Column(
                  children: AppLocalizations.supportedLocales
                      .map(
                        (locale) => _LocalePopupItem(
                          locale: locale,
                          isSelected: locale == currentLocale,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ];
        },
        child: _LocalePopupButton(
          isMenuOpened: isMenuOpened.value,
          currentLocale: currentLocale,
        ),
        onOpened: () => isMenuOpened.value = true,
        onCanceled: () async {
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => isMenuOpened.value = false,
          );
        },
        onSelected: (newLocale) async {
          context.read<LocalizationNotifier>().updateLocale(newLocale);
          isMenuOpened.value = false;
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => isMenuOpened.value = false,
          );
        },
      ),
    );
  }
}

class _LocalePopupItem extends StatelessWidget {
  const _LocalePopupItem({required this.locale, required this.isSelected});

  final Locale locale;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    return PopupMenuItem<Locale>(
      value: locale,
      padding: EdgeInsets.zero,
      child: Container(
        padding: AppSpacings.s12.horizontal + AppSpacings.s8.vertical,
        child: Row(
          children: [
            _flagPaths[locale.languageCode]?.svg(
                  width: _flagWidth,
                  height: _flagHeight,
                ) ??
                const SizedBox.shrink(),
            AppSpacings.s8.horizontalSpace,
            AppText(
              locale.languageCode.toUpperCase(),
              style: AppTextStyles.bodyDefault,
            ),
            AppSpacings.s8.horizontalSpace,
            if (isSelected)
              AppIcon(
                AppStandardIcons.check,
                color: context.colors.foregroundDefaultSecondary,
                size: AppStandardIconSize.s24,
                semanticsLabel: s.languageSelector_selected,
              ),
          ],
        ),
      ),
    );
  }
}

class _LocalePopupButton extends StatelessWidget {
  const _LocalePopupButton({
    required this.currentLocale,
    required this.isMenuOpened,
  });

  final Locale currentLocale;
  final bool isMenuOpened;
  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    return SizedBox(
      width: _popupMenuWidth,
      child: Container(
        padding: AppSpacings.s12.horizontal + AppSpacings.s8.vertical,
        decoration: BoxDecoration(
          borderRadius: isMenuOpened
              ? const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                )
              : BorderRadius.circular(_borderRadius),
          border: Border.all(),
        ),
        child: Row(
          children: [
            _flagPaths[currentLocale.languageCode]?.svg(
                  width: _flagWidth,
                  height: _flagHeight,
                ) ??
                const SizedBox.shrink(),
            AppSpacings.s8.horizontalSpace,
            AppText(
              currentLocale.languageCode.toUpperCase(),
              style: AppTextStyles.bodyDefault,
            ),
            AppSpacings.s8.horizontalSpace,
            AppIcon(
              AppStandardIcons.chevronDown,
              size: AppStandardIconSize.s24,
              color: context.colors.foregroundActivePrimary,
              semanticsLabel: s.languageSelector_openMenu,
            ),
          ],
        ),
      ),
    );
  }
}
