import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/navigation/pop_until.dart';
import 'package:fts/navigation/routes.dart';

Future<void> navigateAfterLogin(BuildContext context) async {
  final authRoutes = [
    const SettingsRoute().location,
    const MenuRoute().location,
    const RegisterRoute().location,
    const VerifyRoute().location,
    const LoginRoute().location,
    const LoginWithCredentialsRoute().location,
    const RecoveryRoute().location,
  ];
  // Go back to where the login was initiated
  await context.popUntil(
    (state) => switch (state.fullPath) {
      null => true,
      final fullPath => authRoutes.none(fullPath.endsWith),
    },
  );
}
