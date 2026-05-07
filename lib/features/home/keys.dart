import 'package:flutter/widgets.dart';

class _HomePageKey extends ValueKey<String> {
  const _HomePageKey(String value) : super('homePage_$value');
}

class HomePageKeys {
  final settingsButton = const _HomePageKey('settingsButton');
  _HomePageKey speakerAvatar(String speakerId) =>
      _HomePageKey('speakerAvatar_$speakerId');
}
