import 'package:fts/features/home/circle_speaker_avatar.dart';
import 'package:fts/keys.dart';

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

  Future<void> tapFirstSpeaker() async {
    await $(CircleSpeakerAvatar).scrollTo();
    await $(CircleSpeakerAvatar).first.tap();
  }
}
