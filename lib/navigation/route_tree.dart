import 'package:fts/navigation/routes.dart';
import 'package:go_router/go_router.dart';

const root = TypedShellRoute<RootRoute>(
  routes: [
    TypedGoRoute<SplashScreenRoute>(path: '/splash-screen'),
    TypedGoRoute<OnboardingRoute>(path: '/onboarding'),
    TypedGoRoute<SettingsRoute>(
      path: '/settings',
      routes: [
        TypedGoRoute<MenuRoute>(
          path: 'menu',
          routes: [
            TypedGoRoute<AccountRoute>(
              path: 'account',
              routes: [
                TypedGoRoute<ChangePasswordRoute>(path: 'change-password'),
                TypedGoRoute<PasskeysRoute>(path: 'passkeys'),
                TypedGoRoute<ReauthorizeRoute>(path: 'reauth'),
              ],
            ),
          ],
        ),
        TypedGoRoute<RegisterRoute>(
          path: 'self-service/register',
          routes: [TypedGoRoute<LoginRoute>(path: 'self-service/login')],
        ),
        TypedGoRoute<VerifyRoute>(path: 'self-service/verification'),
        TypedGoRoute<LoginWithCredentialsRoute>(
          path: 'self-service/login-with-credentials',
        ),
        TypedGoRoute<RecoveryRoute>(path: 'self-service/recovery'),
        TypedGoRoute<DocumentRoute>(path: 'document/:documentType'),
        TypedGoRoute<LicenseRoute>(path: 'license'),
      ],
    ),
    TypedStatefulShellRoute<AppRoute>(
      branches: [
        TypedStatefulShellBranch(
          routes: [
            TypedGoRoute<HomeRoute>(
              path: '/home',
              routes: [
                TypedGoRoute<SpeakerRoute>(
                  path: 'speaker/:speakerId',
                  routes: [
                    TypedGoRoute<SpeakerSessionRoute>(
                      path: 'session/:sessionId',
                    ),
                  ],
                ),
                TypedGoRoute<HomeBranchSessionRoute>(
                  path: 'session/:sessionId',
                  routes: [
                    TypedGoRoute<HomeBranchSessionSpeakerRoute>(
                      path: 'speaker/:speakerId',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        TypedStatefulShellBranch(
          routes: [
            TypedGoRoute<AgendaRoute>(
              path: '/agenda',
              routes: [
                TypedGoRoute<AgendaBranchSessionRoute>(
                  path: 'session/:sessionId',
                  routes: [
                    TypedGoRoute<AgendaBranchSessionSpeakerRoute>(
                      path: 'speaker/:speakerId',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        TypedStatefulShellBranch(
          routes: [TypedGoRoute<MapRoute>(path: '/map')],
        ),
      ],
    ),
  ],
);
