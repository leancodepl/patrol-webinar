import 'package:fts/keys.dart';

import 'module.dart';

final class SessionDetails extends Module {
  const SessionDetails(super.$);

  Future<void> waitForSessionDetailsPage() async {
    await $(keys.sessionDetails.header).waitUntilVisible();
  }
}
