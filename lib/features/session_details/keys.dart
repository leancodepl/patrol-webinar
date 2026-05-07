import 'package:flutter/widgets.dart';

class _SessionDetailsKey extends ValueKey<String> {
  const _SessionDetailsKey(String value) : super('sessionDetails_$value');
}

class SessionDetailsKeys {
  final header = const _SessionDetailsKey('header');
}
