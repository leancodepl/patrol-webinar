import 'package:fts/keys.dart';
import 'package:patrol/patrol.dart';

import 'module.dart';

final class Onboarding extends Module {
  const Onboarding(super.$);

  Future<void> completeOnboarding() async {
    await $(keys.onboarding.continueToAppButton).waitUntilExists();
    // Each of the three onboarding pages builds this button inside an
    // `IgnorePointer`, and only the last page stops ignoring, so the last match
    // is the hit-testable one and scrolling to it pages the `PageView` there.
    await $(keys.onboarding.continueToAppButton).last.scrollTo().tap();
  }
}
