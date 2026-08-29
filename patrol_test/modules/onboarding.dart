import 'package:fts/keys.dart';
import 'package:patrol/patrol.dart';

import 'module.dart';

final class Onboarding extends Module {
  const Onboarding(super.$);

  Future<void> completeOnboarding() async {
    await $(keys.onboarding.continueToAppButton).waitUntilExists();
    await $(keys.onboarding.continueToAppButton).scrollTo().tap();
  }
}
