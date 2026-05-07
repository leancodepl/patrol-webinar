import 'package:flutter/widgets.dart';

class _OnboardingKey extends ValueKey<String> {
  const _OnboardingKey(String value) : super('onboarding_$value');
}

class OnboardingKeys {
  final continueToAppButton = const _OnboardingKey('continueToAppButton');
}
