import 'package:app_design_system/src/widgets/snackbar/snackbar_messenger.dart';
import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter/widgets.dart';

/// A [NavigatorObserver] that removes all snackbars that are not cross-page
/// when any route is either pushed or popped.
///
/// This widget should be provided to the [WidgetsApp] or [MaterialApp] or
/// whatever navigation solution you're using.
class AppSnackbarNavigatorObserver extends NavigatorObserver {
  AppSnackbarNavigatorObserver({required this.messenger});

  final SnackbarMessenger messenger;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    messenger.removeNonCrossPage();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    messenger.removeNonCrossPage();
  }
}
