import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fts/features/app_lifecycle/app_lifecycle_provider.dart';
import 'package:fts/features/connectivity/connectivity_cubit.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

class MockAppLifecycleProvider extends Mock implements AppLifecycleProvider {}

void main() {
  group('ConnectivityCubit', () {
    late MockHttpClient mockClient;
    late MockAppLifecycleProvider mockAppLifecycleProvider;

    const healthCheckConnectedPeriod = Duration(milliseconds: 20);
    const healthCheckDisconnectedPeriod = Duration(milliseconds: 10);
    final healthCheckUri = Uri.parse(
      'https://api.exampleapp.test.lncd.pl/live/health',
    );

    setUpAll(() {
      registerFallbackValue(healthCheckUri);
    });

    setUp(() {
      mockClient = MockHttpClient();
      mockAppLifecycleProvider = MockAppLifecycleProvider();
      when(
        () => mockAppLifecycleProvider.stream,
      ).thenAnswer((_) => const Stream<AppLifecycleStateRecord>.empty());
    });

    ConnectivityCubit build() {
      return ConnectivityCubit(
        appLifecycleProvider: mockAppLifecycleProvider,
        healthCheckUri: healthCheckUri,
        client: mockClient,
        healthCheckConnectedPeriod: healthCheckConnectedPeriod,
        healthCheckDisconnectedPeriod: healthCheckDisconnectedPeriod,
      );
    }

    test('Initial state is ConnectivityState.unknown', () {
      expect(build().state, equals(const ConnectivityStateUnknown()));
    });

    blocTest<ConnectivityCubit, ConnectivityState>(
      'Emits ConnectivityStateConnected after init if request is successful',
      build: () {
        when(
          () => mockClient.get(any()),
        ).thenAnswer((_) async => Response('', 200));
        return build();
      },
      act: (cubit) => cubit.init(),
      skip: 1,
      expect: () => [isA<ConnectivityStateConnected>()],
    );

    blocTest<ConnectivityCubit, ConnectivityState>(
      'Emits ConnectivityStateDisconnected after init if request fails',
      build: () {
        when(
          () => mockClient.get(any()),
        ).thenAnswer((_) async => Response('', 400));
        return build();
      },
      act: (cubit) => cubit.init(),
      skip: 1,
      expect: () => [isA<ConnectivityStateDisconnected>()],
    );

    blocTest<ConnectivityCubit, ConnectivityState>(
      'Emits ConnectivityStateDisconnected after init if client throws an '
      'exception',
      build: () {
        when(
          () => mockClient.get(any()),
        ).thenThrow(ClientException('exception'));
        return build();
      },
      act: (cubit) => cubit.init(),
      skip: 1,
      expect: () => [isA<ConnectivityStateDisconnected>()],
    );

    blocTest<ConnectivityCubit, ConnectivityState>(
      'Emits ['
      'ConnectivityStateDisconnected(isCheckingConnectivity false), '
      'ConnectivityStateDisconnected(isCheckingConnectivity true), '
      'ConnectivityStateConnected(isCheckingConnectivity true)'
      '] if the first request fails and the other one succeeds',
      build: () {
        var index = 0;
        when(() => mockClient.get(any())).thenAnswer((_) async {
          final response = index == 0 ? Response('', 400) : Response('', 200);
          index++;
          return response;
        });
        return build();
      },
      act: (cubit) => cubit.init(),
      wait: healthCheckDisconnectedPeriod,
      skip: 1,
      expect: () => [
        isA<ConnectivityStateDisconnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          false,
        ),
        isA<ConnectivityStateDisconnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          true,
        ),
        isA<ConnectivityStateConnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          false,
        ),
      ],
    );

    blocTest<ConnectivityCubit, ConnectivityState>(
      'Emits ['
      'ConnectivityStateConnected(isCheckingConnectivity false), '
      'ConnectivityStateConnected(isCheckingConnectivity true), '
      'ConnectivityStateDisconnected(isCheckingConnectivity true)'
      '] if the first request succeeds and the other one fails',
      build: () {
        var index = 0;
        when(() => mockClient.get(any())).thenAnswer((_) async {
          final response = index == 0 ? Response('', 200) : Response('', 400);
          index++;
          return response;
        });
        return build();
      },
      act: (cubit) => cubit.init(),
      wait: healthCheckConnectedPeriod,
      skip: 1,
      expect: () => [
        isA<ConnectivityStateConnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          false,
        ),
        isA<ConnectivityStateConnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          true,
        ),
        isA<ConnectivityStateDisconnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          false,
        ),
      ],
    );

    blocTest<ConnectivityCubit, ConnectivityState>(
      'Emits ['
      'ConnectivityStateDisconnected(isCheckingConnectivity: false), '
      'ConnectivityStateDisconnected(isCheckingConnectivity: true), '
      'ConnectivityStateConnected(isCheckingConnectivity: false)'
      '] if the first request fails and then another one succeeds after '
      'successful API result from CQRS Middleware',
      build: () {
        var index = 0;
        when(() => mockClient.get(any())).thenAnswer((_) async {
          final response = index == 0 ? Response('', 400) : Response('', 200);
          index++;
          return response;
        });
        return build();
      },
      act: (cubit) async {
        await cubit.init();
        cubit.onApiResult(CqrsConnectivityResult.success);
      },
      skip: 1,
      expect: () => [
        isA<ConnectivityStateDisconnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          false,
        ),
        isA<ConnectivityStateDisconnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          true,
        ),
        isA<ConnectivityStateConnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          false,
        ),
      ],
    );

    blocTest<ConnectivityCubit, ConnectivityState>(
      'Emits '
      '[ConnectivityStateConnected(isCheckingConnectivity: false), '
      'ConnectivityStateConnected(isCheckingConnectivity: true), '
      'ConnectivityStateDisconnected(isCheckingConnectivity: false)] '
      'if the first request fails and then another one succeeds after '
      'successful API result from CQRS Middleware',
      build: () {
        var index = 0;
        when(() => mockClient.get(any())).thenAnswer((_) async {
          final response = index == 0 ? Response('', 200) : Response('', 400);
          index++;
          return response;
        });
        return build();
      },
      act: (cubit) async {
        await cubit.init();
        cubit.onApiResult(CqrsConnectivityResult.networkError);
      },
      skip: 1,
      expect: () => [
        isA<ConnectivityStateConnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          false,
        ),
        isA<ConnectivityStateConnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          true,
        ),
        isA<ConnectivityStateDisconnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          false,
        ),
      ],
    );

    blocTest<ConnectivityCubit, ConnectivityState>(
      'Emits '
      '[ConnectivityStateDisconnected(isCheckingConnectivity: false), '
      'ConnectivityStateDisconnected(isCheckingConnectivity: true), '
      'ConnectivityStateConnected(isCheckingConnectivity: false)] '
      'if the first request fails and then another one succeeds after multiple '
      'simultaneous successful API results from CQRS Middleware',
      build: () {
        var index = 0;
        when(() => mockClient.get(any())).thenAnswer((_) async {
          final response = index == 0 ? Response('', 400) : Response('', 200);
          index++;
          return response;
        });
        return build();
      },
      act: (cubit) async {
        await cubit.init();
        cubit
          ..onApiResult(CqrsConnectivityResult.success)
          ..onApiResult(CqrsConnectivityResult.success)
          ..onApiResult(CqrsConnectivityResult.success)
          ..onApiResult(CqrsConnectivityResult.success)
          ..onApiResult(CqrsConnectivityResult.success);
      },
      skip: 1,
      expect: () => [
        isA<ConnectivityStateDisconnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          false,
        ),
        isA<ConnectivityStateDisconnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          true,
        ),
        isA<ConnectivityStateConnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          false,
        ),
      ],
    );

    blocTest<ConnectivityCubit, ConnectivityState>(
      'Emits '
      '[ConnectivityStateConnected(isCheckingConnectivity: false), '
      'ConnectivityStateConnected(isCheckingConnectivity: true), '
      'ConnectivityStateDisconnected(isCheckingConnectivity: false)] '
      'if the first request fails and then another one succeeds after multiple '
      'simultaneous successful API results from CQRS Middleware',
      build: () {
        var index = 0;
        when(() => mockClient.get(any())).thenAnswer((_) async {
          final response = index == 0 ? Response('', 200) : Response('', 400);
          index++;
          return response;
        });
        return build();
      },
      act: (cubit) async {
        await cubit.init();
        cubit
          ..onApiResult(CqrsConnectivityResult.networkError)
          ..onApiResult(CqrsConnectivityResult.networkError)
          ..onApiResult(CqrsConnectivityResult.networkError)
          ..onApiResult(CqrsConnectivityResult.networkError)
          ..onApiResult(CqrsConnectivityResult.networkError);
      },
      skip: 1,
      expect: () => [
        isA<ConnectivityStateConnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          false,
        ),
        isA<ConnectivityStateConnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          true,
        ),
        isA<ConnectivityStateDisconnected>().having(
          (state) => state.isCheckingConnectivity,
          'isCheckingConnectivity',
          false,
        ),
      ],
    );

    test(
      'Calls the HTTPClient only two times if the first request fails and then'
      ' the CQRS Middleware simultaneously succeeds multiple requests',
      () async {
        var index = 0;
        when(() => mockClient.get(any())).thenAnswer((_) async {
          final response = index == 0 ? Response('', 400) : Response('', 200);
          index++;
          return response;
        });

        final cubit = build();
        await cubit.init();
        cubit
          ..onApiResult(CqrsConnectivityResult.success)
          ..onApiResult(CqrsConnectivityResult.success)
          ..onApiResult(CqrsConnectivityResult.success)
          ..onApiResult(CqrsConnectivityResult.success)
          ..onApiResult(CqrsConnectivityResult.success);

        verify(() => mockClient.get(any())).called(2);
      },
    );

    test(
      'Calls the HTTPClient only two times if the first request succeeds and'
      ' then the CQRS Middleware simultaneously fails multiple requests',
      () async {
        var index = 0;
        when(() => mockClient.get(any())).thenAnswer((_) async {
          final response = index == 0 ? Response('', 200) : Response('', 400);
          index++;
          return response;
        });

        final cubit = build();
        await cubit.init();
        cubit
          ..onApiResult(CqrsConnectivityResult.networkError)
          ..onApiResult(CqrsConnectivityResult.networkError)
          ..onApiResult(CqrsConnectivityResult.networkError)
          ..onApiResult(CqrsConnectivityResult.networkError)
          ..onApiResult(CqrsConnectivityResult.networkError);

        verify(() => mockClient.get(any())).called(2);
      },
    );
  });
}
