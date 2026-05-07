import 'package:cqrs/cqrs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/http_client/intercepted_http_client.dart';
import 'package:fts/features/auth/interceptors/request/authorization_header_interceptor.dart';
import 'package:fts/features/auth/interceptors/response/unauthorized_interceptor.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:leancode_debug_page/leancode_debug_page.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> useKratosProviders({
  required Uri kratosUri,
  required FlutterSecureCredentialsStorage flutterSecureCredentialsStorage,
  required InterceptedHttpClient interceptedHttpClient,
  required Cqrs cqrs,
  LoggingHttpClient? httpClient,
}) {
  final kratosClient = useMemoized(
    () => KratosClient(baseUri: kratosUri, httpClient: httpClient),
  );

  final authCubit = useMemoized(
    () => AuthCubit(
      storage: flutterSecureCredentialsStorage,
      kratosClient: kratosClient,
    )..init(),
  );

  final unauthorizedInterceptor = useMemoized(
    () => UnauthorizedInterceptor(authCubit: authCubit),
  );

  final authorizationHeaderInterceptor = useMemoized(
    () => AuthorizationHeaderInterceptor(
      flutterSecureCredentialsStorage: flutterSecureCredentialsStorage,
    ),
  );

  useOnStreamChange(
    authCubit.stream,
    onData: (event) {
      if (event is AuthStateLoggedIn) {
        interceptedHttpClient
          ..addRequestInterceptor(authorizationHeaderInterceptor)
          ..addResponseInterceptor(unauthorizedInterceptor);
      } else if (event is AuthStateUnauthorized) {
        interceptedHttpClient
          ..removeRequestInterceptor(authorizationHeaderInterceptor)
          ..removeResponseInterceptor(unauthorizedInterceptor);
      }
    },
  );

  return [
    Provider.value(value: kratosClient),
    BlocProvider.value(value: authCubit),
  ];
}
