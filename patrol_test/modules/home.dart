import 'package:fts/keys.dart';
import 'package:patrol/patrol.dart';

import 'module.dart';

final class Home extends Module {
  const Home(super.$);

  Future<void> waitForHomePage() async {
    await $(keys.appShell.homeTab).waitUntilVisible();
  }

  Future<void> goToAgenda() async {
    await $(keys.appShell.agendaTab).tap();
  }

  Future<void> openSettings() async {
    await $(keys.home.settingsButton).tap();
  }

  Future<void> tapSpeaker(String speakerName) async {
    await $(keys.home.speakerAvatar(speakerName)).scrollTo().tap();
  }
}
