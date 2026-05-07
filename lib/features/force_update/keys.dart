import 'package:flutter/widgets.dart';

class _AppForceUpdateScreenKey extends ValueKey<String> {
  const _AppForceUpdateScreenKey(String value)
    : super('appForceUpdateScreen_$value');
}

class AppForceUpdateScreenKeys {
  final screen = const _AppForceUpdateScreenKey('screen');
  final updateButton = const _AppForceUpdateScreenKey('updateButton');
}

class _AppSuggestUpdateDialogKey extends ValueKey<String> {
  const _AppSuggestUpdateDialogKey(String value)
    : super('appSuggestUpdateDialog_$value');
}

class AppSuggestUpdateDialogKeys {
  final cancelButton = const _AppSuggestUpdateDialogKey('cancelButton');
  final dialog = const _AppSuggestUpdateDialogKey('dialog');
  final updateButton = const _AppSuggestUpdateDialogKey('updateButton');
}
