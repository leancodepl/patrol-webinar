import 'package:flutter/widgets.dart';
import 'package:fts/common/config/app_config.dart';
import 'package:fts/main_common.dart';

final _defaultEndpoint = Uri.parse(
  'https://api.patrol-webinar.test.lncd.pl/api/',
);

Future<AppConfig> getPatrolConfig({bool enableForceUpdate = false}) async {
  return _getTstConfig(
    showDebugOverlay: false,
    enableForceUpdate: enableForceUpdate,
  );
}

AppConfig _getTstConfig({
  Uri? apiEndpoint,
  bool showDebugOverlay = true,
  bool enableForceUpdate = false,
}) {
  return AppConfig.debug(
    apiUri: apiEndpoint ?? _defaultEndpoint,
    pipeUri: Uri.parse('https://patrol-webinar.test.lncd.pl/leanpipe'),
    kratosUri: Uri.parse('https://auth.patrol-webinar.test.lncd.pl'),
    healthCheckUri: Uri.parse(
      'https://api.patrol-webinar.test.lncd.pl/live/health',
    ),
    showDebugOverlay: showDebugOverlay,
    enableForceUpdate: enableForceUpdate,
  );
}

Future<void> main() {
  // Early initialization required by overrideApiEndpoint's SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();

  return mainCommon(config: _getTstConfig());
}
