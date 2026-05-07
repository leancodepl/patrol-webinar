import 'package:cqrs/cqrs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/common/config/app_config.dart';
import 'package:fts/common/config/app_global_keys.dart';
import 'package:fts/common/hooks/use_global_key.dart';
import 'package:fts/common/http_client/intercepted_http_client.dart';
import 'package:fts/common/services/location_service.dart';
import 'package:fts/data/middlewares/error_handling_cqrs_middleware.dart';
import 'package:fts/features/agenda/agenda_cubit.dart';
import 'package:fts/features/app_lifecycle/app_lifecycle_provider.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/auth/kratos/di/providers.dart';
import 'package:fts/features/auth/passkey/common/passkey_credential_manager/passkey_credential_manager.dart';
import 'package:fts/features/auth/passkey/common/passkey_credential_manager/passkey_credential_manager_impl.dart';
import 'package:fts/features/auth/user/user_repository.dart';
import 'package:fts/features/connectivity/connectivity_cubit.dart';
import 'package:fts/features/connectivity/connectivity_middleware.dart';
import 'package:fts/features/localization/localization_notifier.dart';
import 'package:fts/features/onboarding/onboarding_cubit.dart';
import 'package:fts/features/rating/rate_cubit.dart';
import 'package:fts/features/settings/settings_cubit.dart';
import 'package:leancode_app_rating/leancode_app_rating.dart';
import 'package:leancode_debug_page/leancode_debug_page.dart';
import 'package:leancode_force_update/leancode_force_update.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';
import 'package:leancode_pipe/leancode_pipe/pipe_client.dart';
import 'package:location/location.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:passkeys/authenticator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalProviders extends HookWidget {
  const GlobalProviders({
    super.key,
    required this.config,
    required this.packageInfo,
    required this.prefs,
    required this.child,
  });

  final AppConfig config;
  final PackageInfo packageInfo;
  final Widget child;
  final SharedPreferences prefs;

  Map<String, String> _getLeanCodeHeaders() {
    final platform = switch (defaultTargetPlatform) {
      TargetPlatform.android => 'android',
      TargetPlatform.iOS => 'ios',
      TargetPlatform.windows => 'windows',
      TargetPlatform.macOS => 'macos',
      TargetPlatform.linux => 'linux',
      TargetPlatform.fuchsia => 'fuchsia',
    };

    final ua =
        '${packageInfo.packageName}/${packageInfo.version} (${packageInfo.buildNumber}; $platform)';

    return {
      if (!kIsWeb) 'User-Agent': ua,
      'x-lncd-app': packageInfo.packageName,
      'x-lncd-app-version': packageInfo.version,
      'x-lncd-app-build-number': packageInfo.buildNumber,
      'x-lncd-platform': platform,
    };
  }

  @override
  Widget build(BuildContext context) {
    final navigatorKey = useGlobalKey<NavigatorState>();
    final navigationBarKey = useGlobalKey();

    final flutterSecureStorage = useMemoized(
      FlutterSecureCredentialsStorage.new,
    );

    final interceptedHttpClient = useMemoized(InterceptedHttpClient.new);

    final httpClient = useMemoized(
      () => LoggingHttpClient(client: interceptedHttpClient),
    );

    final appLifecycleProvider = useMemoized(AppLifecycleProvider.new);

    final connectivityCubit = useMemoized(
      () => ConnectivityCubit(
        appLifecycleProvider: appLifecycleProvider,
        healthCheckUri: config.healthCheckUri,
        client: httpClient,
        healthCheckConnectedPeriod: const Duration(seconds: 30),
        healthCheckDisconnectedPeriod: const Duration(seconds: 5),
      )..init(),
    );

    final connectivityMiddleware = useMemoized(
      () => ConnectivityCqrsMiddleware(connectivityCubit: connectivityCubit),
    );

    final cqrs = useMemoized(
      () => Cqrs(
        httpClient,
        config.apiUri,
        headers: _getLeanCodeHeaders(),
        logger: Logger('Cqrs'),
        middlewares: [
          ErrorHandlingCqrsMiddleware(navigatorKey),
          connectivityMiddleware,
        ],
      ),
    );

    final kratosProviders = useKratosProviders(
      kratosUri: config.kratosUri,
      httpClient: httpClient,
      flutterSecureCredentialsStorage: flutterSecureStorage,
      interceptedHttpClient: interceptedHttpClient,
      cqrs: cqrs,
    );

    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AppGlobalKeys(
            navigatorKey: navigatorKey,
            navigationBarKey: navigationBarKey,
          ),
        ),
        Provider.value(value: config),
        Provider(
          create: (context) => ForceUpdateController(
            androidBundleId: 'pl.leancode.fts',
            appleAppId: '6745612994',
          ),
        ),
        Provider.value(value: flutterSecureStorage),
        Provider.value(value: interceptedHttpClient),
        Provider.value(value: cqrs),
        Provider.value(value: httpClient),
        Provider(
          create: (context) => PipeClient(
            pipeUrl: config.pipeUri.toString(),
            tokenFactory: () async {
              final credentials = await flutterSecureStorage.read();

              return credentials ?? '';
            },
          ),
        ),
        Provider(
          create: (context) => AppRating(
            cqrs: cqrs,
            appleStoreId: '111111',
            appVersion: packageInfo.version,
          ),
        ),
        Provider.value(value: appLifecycleProvider),
        Provider(create: (context) => Location()),
        Provider.value(value: connectivityCubit),
        ...kratosProviders,
        Provider(
          create: (context) => UserRepository(kratosClient: context.read()),
        ),
        Provider(
          create: (context) => LocationService(location: context.read()),
          dispose: (context, service) => service.dispose(),
        ),
        Provider<PasskeyCredentialManager>(
          create: (context) => PasskeyCredentialManagerImpl(
            authenticator: PasskeyAuthenticator(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => LocalizationNotifier()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => OnboardingCubit(prefs: prefs)),
          BlocProvider(
            create: (context) => AppSettingsCubit(sharedPreferences: prefs),
          ),
          BlocProvider(create: (context) => RateCubit(cqrs: context.read())),
          BlocProvider(
            create: (context) => AgendaCubit(
              cqrs: context.read(),
              rateEventStream: context.read<RateCubit>().presentation,
              authEventStream: context.read<AuthCubit>().stream,
            )..run(),
          ),
        ],
        child: child,
      ),
    );
  }
}
