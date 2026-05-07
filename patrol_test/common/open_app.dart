import 'dart:convert';

import 'package:fts/main_common.dart';
import 'package:fts/main_tst.dart';
import 'package:leancode_force_update/data/contracts/contracts.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:patrol/patrol.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> openApp(
  PatrolIntegrationTester $, {
  VersionSupportResultDTO versionSupport = VersionSupportResultDTO.upToDate,
}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  await FlutterSecureCredentialsStorage().clear();

  if (versionSupport != VersionSupportResultDTO.upToDate) {
    final packageInfo = await PackageInfo.fromPlatform();
    final result = {
      'versionAtTimeOfRequest': packageInfo.version,
      'conclusion': versionSupport.index,
    };
    await prefs.setString('most_recent_result', jsonEncode(result));
  }

  await $.pumpWidget(await prepareApp(config: await getPatrolConfig()));
}
