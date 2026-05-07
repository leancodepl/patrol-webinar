import 'package:fts/keys.dart';

import 'module.dart';

final class SpeakerDetails extends Module {
  const SpeakerDetails(super.$);

  Future<void> waitForSpeakerDetailsPage() async {
    await $(keys.speakerDetails.speakerName).waitUntilVisible();
  }
}
