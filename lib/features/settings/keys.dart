import 'package:flutter/widgets.dart';

class _SettingsPageKey extends ValueKey<String> {
  const _SettingsPageKey(String value) : super('settingsPage_$value');
}

class SettingsPageKeys {
  final accountItem = const _SettingsPageKey('accountItem');
  final signUpButton = const _SettingsPageKey('signUpButton');
}
