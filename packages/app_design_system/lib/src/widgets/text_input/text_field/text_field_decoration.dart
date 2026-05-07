import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:flutter/widgets.dart';

final class AppTextFieldOption {
  const AppTextFieldOption({
    this.key,
    required this.label,
    required this.items,
  });

  final Key? key;
  final String label;
  final List<Widget> items;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AppTextFieldOption &&
        other.key == key &&
        other.label == label &&
        other.items == items;
  }

  @override
  int get hashCode => Object.hash(key, label, items);
}

final class AppTextFieldAction {
  const AppTextFieldAction({
    this.key,
    this.icon,
    required this.label,
    required this.onTap,
  });

  final Key? key;
  final AppStandardIconData? icon;
  final String label;
  final VoidCallback onTap;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AppTextFieldAction &&
        other.key == key &&
        other.icon == icon &&
        other.label == label &&
        other.onTap == onTap;
  }

  @override
  int get hashCode => Object.hash(key, icon, label, onTap);
}

enum AppTextFieldSize {
  medium,
  large;

  EdgeInsetsDirectional get verticalPadding => switch (this) {
    medium => AppSpacings.s8.vertical,
    large => AppSpacings.s12.vertical,
  };
}

final class AppTextFieldDecoration {
  const AppTextFieldDecoration({
    this.size = AppTextFieldSize.medium,
    this.label,
    this.leadingIcon,
    this.leadingOption,
    this.prefix,
    this.clearable = true,
    this.suffix,
    this.trailingOption,
    this.trailingIcon,
    this.action,
    this.placeholder,
    this.help,
    this.helpKey,
    this.hint,
    this.error,
  });

  final AppTextFieldSize size;
  final String? label;
  final AppStandardIconData? leadingIcon;
  final AppTextFieldOption? leadingOption;
  final String? prefix;
  final bool clearable;
  final String? suffix;
  final AppTextFieldOption? trailingOption;
  final AppStandardIconData? trailingIcon;
  final AppTextFieldAction? action;
  final String? placeholder;
  final String? help;
  final Key? helpKey;
  final String? hint;
  final String? error;
}
