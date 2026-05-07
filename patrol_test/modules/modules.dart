import 'package:patrol/patrol.dart';

import 'agenda.dart';
import 'app_update.dart';
import 'auth.dart';
import 'home.dart';
import 'onboarding.dart';
import 'session_details.dart';
import 'settings.dart';
import 'speaker_details.dart';

final class Modules {
  Modules(this._$);

  final PatrolIntegrationTester _$;

  late final agenda = Agenda(_$);
  late final appUpdate = AppUpdate(_$);
  late final auth = Auth(_$);
  late final home = Home(_$);
  late final onboarding = Onboarding(_$);
  late final sessionDetails = SessionDetails(_$);
  late final settings = Settings(_$);
  late final speakerDetails = SpeakerDetails(_$);
}
