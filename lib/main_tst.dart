import 'package:flutter/widgets.dart';
import 'package:fts/common/config/app_config.dart';
import 'package:fts/main_common.dart';

final _defaultEndpoint = Uri.parse(
  'https://api.patrol-webinar.test.lncd.pl/api/',
);

Future<AppConfig> getPatrolConfig() async {
  return _getTstConfig(showDebugOverlay: false);
}

AppConfig _getTstConfig({Uri? apiEndpoint, bool showDebugOverlay = true}) {
  return AppConfig.debug(
    apiUri: apiEndpoint ?? _defaultEndpoint,
    pipeUri: Uri.parse('https://patrol-webinar.test.lncd.pl/leanpipe'),
    kratosUri: Uri.parse('https://auth.patrol-webinar.test.lncd.pl'),
    healthCheckUri: Uri.parse(
      'https://api.patrol-webinar.test.lncd.pl/live/health',
    ),
    showDebugOverlay: showDebugOverlay,
  );
}

Future<void> main() {
  // Early initialization required by overrideApiEndpoint's SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();

  return mainCommon(config: _getTstConfig());
}
