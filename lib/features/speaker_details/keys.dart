import 'package:flutter/widgets.dart';

class _SpeakerDetailsPageKey extends ValueKey<String> {
  const _SpeakerDetailsPageKey(String value)
    : super('speakerDetailsPage_$value');
}

class SpeakerDetailsPageKeys {
  final speakerName = const _SpeakerDetailsPageKey('speakerName');
}
