import 'package:flutter/widgets.dart';

class AppGlobalKeys {
  const AppGlobalKeys({
    required this.navigatorKey,
    required this.navigationBarKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final GlobalKey navigationBarKey;
}
