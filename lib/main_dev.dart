import 'package:clock/clock.dart';
import 'package:fts/common/config/app_config.dart';
import 'package:fts/main_common.dart';

void main() {
  final config = AppConfig.debug(
    apiUri: Uri.parse('https://api.patrol-webinar.test.lncd.pl/api/'),
    pipeUri: Uri.parse('https://patrol-webinar.test.lncd.pl/leanpipe'),
    kratosUri: Uri.parse('https://auth.patrol-webinar.test.lncd.pl'),
    healthCheckUri: Uri.parse(
      'https://api.patrol-webinar.test.lncd.pl/live/health',
    ),
  );

  // TODO: remove fixed clock
  withClock(Clock.fixed(DateTime(2025, 6, 5, 12, 0, 1)), () {
    mainCommon(config: config);
  });
}
