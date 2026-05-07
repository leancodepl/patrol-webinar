import 'package:flutter/widgets.dart';

class _AppShellKey extends ValueKey<String> {
  const _AppShellKey(String value) : super('appShell_$value');
}

class AppShellKeys {
  final agendaTab = const _AppShellKey('agendaTab');
  final homeTab = const _AppShellKey('homeTab');
  final mapTab = const _AppShellKey('mapTab');
}
