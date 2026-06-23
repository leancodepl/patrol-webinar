import 'package:flutter/widgets.dart';
import 'package:fts/keys.dart';

import 'module.dart';

final class Onboarding extends Module {
  const Onboarding(super.$);

  Future<void> completeOnboarding() async {
    await $(keys.onboarding.continueToAppButton).waitUntilExists();
    // The onboarding has 3 pages and the continue button is only tappable on
    // the last one, so swipe to the final page before tapping.
    await _swipeToNextPage();
    await _swipeToNextPage();
    await $(keys.onboarding.continueToAppButton).tap();
  }

  Future<void> _swipeToNextPage() async {
    await $.platform.mobile.swipe(
      from: const Offset(0.8, 0.5),
      to: const Offset(0.2, 0.5),
    );
  }
}
