import 'package:flutter/material.dart' show LicensePage;
import 'package:flutter/widgets.dart';
import 'package:fts/common/keys/page_ids.dart';
import 'package:fts/features/agenda/agenda_page.dart';
import 'package:fts/features/app_shell.dart';
import 'package:fts/features/auth/login/login_page.dart';
import 'package:fts/features/auth/login/login_with_credentials_page.dart';
import 'package:fts/features/auth/menu/change_password/change_password_page.dart';
import 'package:fts/features/auth/menu/menu_page.dart';
import 'package:fts/features/auth/reauthorize/reauthorize_page.dart';
import 'package:fts/features/auth/recovery/recovery_page.dart';
import 'package:fts/features/auth/register/register_page.dart';
import 'package:fts/features/auth/verification/verification_page.dart';
import 'package:fts/features/home/home_page.dart';
import 'package:fts/features/map/map_page.dart';
import 'package:fts/features/onboarding/onboarding_page.dart';
import 'package:fts/features/push_notifications/push_notifications_dispatcher.dart';
import 'package:fts/features/session_details/session_details_page.dart';
import 'package:fts/features/settings/account/account_page.dart';
import 'package:fts/features/settings/account/passkeys_page.dart';
import 'package:fts/features/settings/document_page.dart';
import 'package:fts/features/settings/settings_page.dart';
import 'package:fts/features/speaker_details/speaker_details_page.dart';
import 'package:fts/features/splash_screen/splash_screen_page.dart';
import 'package:fts/navigation/route_tree.dart';
import 'package:fts/navigation/router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part 'routes.g.dart';

@root
class RootRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return Provider(
      lazy: false,
      create: (context) => PushNotificationsDispatcher(),
      child: navigator,
    );
  }
}

class MenuRoute extends AppGoRouteData with $MenuRoute {
  const MenuRoute() : super(id: PageId.menu, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const MenuPage();
}

class ReauthorizeRoute extends AppGoRouteData with $ReauthorizeRoute {
  const ReauthorizeRoute() : super(id: PageId.reauthorize, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const ReauthorizePage();
}

class ChangePasswordRoute extends AppGoRouteData with $ChangePasswordRoute {
  const ChangePasswordRoute() : super(id: PageId.changePassword, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const ChangePasswordPage();
}

class AccountRoute extends AppGoRouteData with $AccountRoute {
  const AccountRoute() : super(id: PageId.account, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const AccountPage();
}

class PasskeysRoute extends AppGoRouteData with $PasskeysRoute {
  const PasskeysRoute() : super(id: PageId.passkeys, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const PasskeysPage();
}

class RegisterRoute extends AppGoRouteData with $RegisterRoute {
  const RegisterRoute() : super(id: PageId.register, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const RegisterPage();
}

class LoginRoute extends AppGoRouteData with $LoginRoute {
  const LoginRoute() : super(id: PageId.login, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const LoginPage();
}

class LoginWithCredentialsRoute extends AppGoRouteData
    with $LoginWithCredentialsRoute {
  const LoginWithCredentialsRoute()
    : super(id: PageId.loginWithCredentials, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const LoginWithCredentialsPage();
}

class VerifyRoute extends AppGoRouteData with $VerifyRoute {
  const VerifyRoute({this.email, this.flowId, this.code})
    : super(
        id: PageId.verify,
        arguments: (email: email, flowId: flowId, code: code),
      );

  final String? email;
  final String? flowId;
  final String? code;

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      VerificationPage(email: email, flowId: flowId, code: code);
}

class RecoveryRoute extends AppGoRouteData with $RecoveryRoute {
  const RecoveryRoute() : super(id: PageId.recovery, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const RecoveryPage();
}

class AppRoute extends StatefulShellRouteData {
  const AppRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return navigationShell;
  }

  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    return AppShell(navigationShell: navigationShell, children: children);
  }
}

class HomeRoute extends AppGoRouteData with $HomeRoute {
  const HomeRoute() : super(id: PageId.homePage, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const HomePage();
}

class SettingsRoute extends AppGoRouteData with $SettingsRoute {
  const SettingsRoute() : super(id: PageId.settings, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const SettingsPage();
}

sealed class SessionRoute extends AppGoRouteData {
  const SessionRoute({required super.arguments})
    : super(id: PageId.sessionDetails);

  String get sessionId;
}

class AgendaBranchSessionRoute extends SessionRoute
    with $AgendaBranchSessionRoute {
  AgendaBranchSessionRoute(this.sessionId)
    : super(arguments: (sessionId: sessionId));

  @override
  final String sessionId;

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      SessionDetailsPage(
        id: sessionId,
        onSpeakerTap: (speaker) =>
            AgendaBranchSessionSpeakerRoute(sessionId, speaker.id).go(context),
      );
}

class HomeBranchSessionRoute extends SessionRoute with $HomeBranchSessionRoute {
  HomeBranchSessionRoute(this.sessionId)
    : super(arguments: (sessionId: sessionId));

  @override
  final String sessionId;

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      SessionDetailsPage(
        id: sessionId,
        onSpeakerTap: (speaker) =>
            HomeBranchSessionSpeakerRoute(sessionId, speaker.id).go(context),
      );
}

class SpeakerRoute extends AppGoRouteData with $SpeakerRoute {
  SpeakerRoute({required this.speakerId})
    : super(id: PageId.speakerDetails, arguments: (speakerId: speakerId));

  final String speakerId;

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      SpeakerDetailsPage(
        id: speakerId,
        onSessionTap: (session) => SpeakerSessionRoute(
          speakerId: speakerId,
          sessionId: session.id,
        ).go(context),
      );
}

class SpeakerSessionRoute extends SessionRoute with $SpeakerSessionRoute {
  SpeakerSessionRoute({required this.speakerId, required this.sessionId})
    : super(arguments: (speakerId: speakerId, sessionId: sessionId));

  final String speakerId;
  @override
  final String sessionId;

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      SessionDetailsPage(
        id: sessionId,
        onSpeakerTap: (speaker) =>
            SpeakerRoute(speakerId: speaker.id).go(context),
      );
}

sealed class SessionSpeakerRoute extends AppGoRouteData {
  const SessionSpeakerRoute({required super.arguments})
    : super(id: PageId.speakerDetails);

  String get sessionId;
  String get speakerId;
}

class AgendaBranchSessionSpeakerRoute extends SessionSpeakerRoute
    with $AgendaBranchSessionSpeakerRoute {
  AgendaBranchSessionSpeakerRoute(this.sessionId, this.speakerId)
    : super(arguments: (sessionId: sessionId, speakerId: speakerId));

  @override
  final String sessionId;
  @override
  final String speakerId;

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      SpeakerDetailsPage(
        id: speakerId,
        onSessionTap: (session) =>
            AgendaBranchSessionRoute(session.id).go(context),
      );
}

class HomeBranchSessionSpeakerRoute extends SessionSpeakerRoute
    with $HomeBranchSessionSpeakerRoute {
  HomeBranchSessionSpeakerRoute(this.sessionId, this.speakerId)
    : super(arguments: (sessionId: sessionId, speakerId: speakerId));

  @override
  final String sessionId;
  @override
  final String speakerId;

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      SpeakerDetailsPage(
        id: speakerId,
        onSessionTap: (session) =>
            HomeBranchSessionRoute(session.id).go(context),
      );
}

class MapRoute extends AppGoRouteData with $MapRoute {
  const MapRoute() : super(id: PageId.map, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const MapPage();
}

class AgendaRoute extends AppGoRouteData with $AgendaRoute {
  const AgendaRoute() : super(id: PageId.agenda, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const AgendaPage();
}

class SplashScreenRoute extends AppGoRouteData with $SplashScreenRoute {
  const SplashScreenRoute() : super(id: PageId.splashScreen, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const SplashScreenPage();
}

class DocumentRoute extends AppGoRouteData with $DocumentRoute {
  const DocumentRoute(this.documentType)
    : super(id: PageId.legalDocument, arguments: (documentType: documentType));

  final DocumentType documentType;

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      DocumentPage(documentType: documentType);
}

class LicenseRoute extends AppGoRouteData with $LicenseRoute {
  const LicenseRoute() : super(id: PageId.license, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const LicensePage();
}

class OnboardingRoute extends AppGoRouteData with $OnboardingRoute {
  const OnboardingRoute() : super(id: PageId.onboarding, arguments: ());

  @override
  Widget buildAppPage(BuildContext context, GoRouterState state) =>
      const OnboardingPage();
}
