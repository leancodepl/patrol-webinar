import 'package:flutter/foundation.dart';
import 'package:patrol/patrol.dart';

final class System extends PlatformAutomator {
  System({required super.config});

  Future<void> grantPermission() async {
    if (await mobile.isPermissionDialogVisible()) {
      await mobile.grantPermissionWhenInUse();
    }
  }

  Future<void> disableConnectivity() async {
    await mobile.disableWifi();
    await mobile.disableCellular();
  }

  Future<void> enableConnectivity() async {
    await mobile.enableWifi();
    await mobile.enableCellular();
  }

  Future<void> openNotificationByText(String text) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await ios.closeHeadsUpNotification();
    }
    await mobile.openNotifications();
    await mobile.tapOnNotificationBySelector(Selector(textContains: text));
  }
}
