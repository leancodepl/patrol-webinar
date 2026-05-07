// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$rootRoute];

RouteBase get $rootRoute => ShellRouteData.$route(
  factory: $RootRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/splash-screen',
      factory: $SplashScreenRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/onboarding',
      factory: $OnboardingRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/settings',
      factory: $SettingsRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'menu',
          factory: $MenuRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'account',
              factory: $AccountRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'change-password',
                  factory: $ChangePasswordRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'passkeys',
                  factory: $PasskeysRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'reauth',
                  factory: $ReauthorizeRoute._fromState,
                ),
              ],
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'self-service/register',
          factory: $RegisterRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'self-service/login',
              factory: $LoginRoute._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'self-service/verification',
          factory: $VerifyRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'self-service/login-with-credentials',
          factory: $LoginWithCredentialsRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'self-service/recovery',
          factory: $RecoveryRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'document/:documentType',
          factory: $DocumentRoute._fromState,
        ),
        GoRouteData.$route(path: 'license', factory: $LicenseRoute._fromState),
      ],
    ),
    StatefulShellRouteData.$route(
      navigatorContainerBuilder: AppRoute.$navigatorContainerBuilder,
      factory: $AppRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/home',
              factory: $HomeRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'speaker/:speakerId',
                  factory: $SpeakerRoute._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'session/:sessionId',
                      factory: $SpeakerSessionRoute._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'session/:sessionId',
                  factory: $HomeBranchSessionRoute._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'speaker/:speakerId',
                      factory: $HomeBranchSessionSpeakerRoute._fromState,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/agenda',
              factory: $AgendaRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'session/:sessionId',
                  factory: $AgendaBranchSessionRoute._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'speaker/:speakerId',
                      factory: $AgendaBranchSessionSpeakerRoute._fromState,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(path: '/map', factory: $MapRoute._fromState),
          ],
        ),
      ],
    ),
  ],
);

extension $RootRouteExtension on RootRoute {
  static RootRoute _fromState(GoRouterState state) => RootRoute();
}

mixin $SplashScreenRoute on GoRouteData {
  static SplashScreenRoute _fromState(GoRouterState state) =>
      const SplashScreenRoute();

  @override
  String get location => GoRouteData.$location('/splash-screen');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $OnboardingRoute on GoRouteData {
  static OnboardingRoute _fromState(GoRouterState state) =>
      const OnboardingRoute();

  @override
  String get location => GoRouteData.$location('/onboarding');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MenuRoute on GoRouteData {
  static MenuRoute _fromState(GoRouterState state) => const MenuRoute();

  @override
  String get location => GoRouteData.$location('/settings/menu');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AccountRoute on GoRouteData {
  static AccountRoute _fromState(GoRouterState state) => const AccountRoute();

  @override
  String get location => GoRouteData.$location('/settings/menu/account');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ChangePasswordRoute on GoRouteData {
  static ChangePasswordRoute _fromState(GoRouterState state) =>
      const ChangePasswordRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/menu/account/change-password');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PasskeysRoute on GoRouteData {
  static PasskeysRoute _fromState(GoRouterState state) => const PasskeysRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/menu/account/passkeys');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ReauthorizeRoute on GoRouteData {
  static ReauthorizeRoute _fromState(GoRouterState state) =>
      const ReauthorizeRoute();

  @override
  String get location => GoRouteData.$location('/settings/menu/account/reauth');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $RegisterRoute on GoRouteData {
  static RegisterRoute _fromState(GoRouterState state) => const RegisterRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/self-service/register');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location(
    '/settings/self-service/register/self-service/login',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $VerifyRoute on GoRouteData {
  static VerifyRoute _fromState(GoRouterState state) => VerifyRoute(
    email: state.uri.queryParameters['email'],
    flowId: state.uri.queryParameters['flow-id'],
    code: state.uri.queryParameters['code'],
  );

  VerifyRoute get _self => this as VerifyRoute;

  @override
  String get location => GoRouteData.$location(
    '/settings/self-service/verification',
    queryParams: {
      if (_self.email != null) 'email': _self.email,
      if (_self.flowId != null) 'flow-id': _self.flowId,
      if (_self.code != null) 'code': _self.code,
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LoginWithCredentialsRoute on GoRouteData {
  static LoginWithCredentialsRoute _fromState(GoRouterState state) =>
      const LoginWithCredentialsRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/self-service/login-with-credentials');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $RecoveryRoute on GoRouteData {
  static RecoveryRoute _fromState(GoRouterState state) => const RecoveryRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/self-service/recovery');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DocumentRoute on GoRouteData {
  static DocumentRoute _fromState(GoRouterState state) => DocumentRoute(
    _$DocumentTypeEnumMap._$fromName(state.pathParameters['documentType']!)!,
  );

  DocumentRoute get _self => this as DocumentRoute;

  @override
  String get location => GoRouteData.$location(
    '/settings/document/${Uri.encodeComponent(_$DocumentTypeEnumMap[_self.documentType]!)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

const _$DocumentTypeEnumMap = {
  DocumentType.privacyPolicy: 'privacy-policy',
  DocumentType.termsOfService: 'terms-of-service',
};

mixin $LicenseRoute on GoRouteData {
  static LicenseRoute _fromState(GoRouterState state) => const LicenseRoute();

  @override
  String get location => GoRouteData.$location('/settings/license');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

extension $AppRouteExtension on AppRoute {
  static AppRoute _fromState(GoRouterState state) => const AppRoute();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SpeakerRoute on GoRouteData {
  static SpeakerRoute _fromState(GoRouterState state) =>
      SpeakerRoute(speakerId: state.pathParameters['speakerId']!);

  SpeakerRoute get _self => this as SpeakerRoute;

  @override
  String get location => GoRouteData.$location(
    '/home/speaker/${Uri.encodeComponent(_self.speakerId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SpeakerSessionRoute on GoRouteData {
  static SpeakerSessionRoute _fromState(GoRouterState state) =>
      SpeakerSessionRoute(
        speakerId: state.pathParameters['speakerId']!,
        sessionId: state.pathParameters['sessionId']!,
      );

  SpeakerSessionRoute get _self => this as SpeakerSessionRoute;

  @override
  String get location => GoRouteData.$location(
    '/home/speaker/${Uri.encodeComponent(_self.speakerId)}/session/${Uri.encodeComponent(_self.sessionId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $HomeBranchSessionRoute on GoRouteData {
  static HomeBranchSessionRoute _fromState(GoRouterState state) =>
      HomeBranchSessionRoute(state.pathParameters['sessionId']!);

  HomeBranchSessionRoute get _self => this as HomeBranchSessionRoute;

  @override
  String get location => GoRouteData.$location(
    '/home/session/${Uri.encodeComponent(_self.sessionId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $HomeBranchSessionSpeakerRoute on GoRouteData {
  static HomeBranchSessionSpeakerRoute _fromState(GoRouterState state) =>
      HomeBranchSessionSpeakerRoute(
        state.pathParameters['sessionId']!,
        state.pathParameters['speakerId']!,
      );

  HomeBranchSessionSpeakerRoute get _self =>
      this as HomeBranchSessionSpeakerRoute;

  @override
  String get location => GoRouteData.$location(
    '/home/session/${Uri.encodeComponent(_self.sessionId)}/speaker/${Uri.encodeComponent(_self.speakerId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AgendaRoute on GoRouteData {
  static AgendaRoute _fromState(GoRouterState state) => const AgendaRoute();

  @override
  String get location => GoRouteData.$location('/agenda');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AgendaBranchSessionRoute on GoRouteData {
  static AgendaBranchSessionRoute _fromState(GoRouterState state) =>
      AgendaBranchSessionRoute(state.pathParameters['sessionId']!);

  AgendaBranchSessionRoute get _self => this as AgendaBranchSessionRoute;

  @override
  String get location => GoRouteData.$location(
    '/agenda/session/${Uri.encodeComponent(_self.sessionId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AgendaBranchSessionSpeakerRoute on GoRouteData {
  static AgendaBranchSessionSpeakerRoute _fromState(GoRouterState state) =>
      AgendaBranchSessionSpeakerRoute(
        state.pathParameters['sessionId']!,
        state.pathParameters['speakerId']!,
      );

  AgendaBranchSessionSpeakerRoute get _self =>
      this as AgendaBranchSessionSpeakerRoute;

  @override
  String get location => GoRouteData.$location(
    '/agenda/session/${Uri.encodeComponent(_self.sessionId)}/speaker/${Uri.encodeComponent(_self.speakerId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MapRoute on GoRouteData {
  static MapRoute _fromState(GoRouterState state) => const MapRoute();

  @override
  String get location => GoRouteData.$location('/map');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

extension<T extends Enum> on Map<T, String> {
  T? _$fromName(String? value) =>
      entries.where((element) => element.value == value).firstOrNull?.key;
}
