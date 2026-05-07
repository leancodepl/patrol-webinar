import 'package:cqrs/cqrs.dart';
import 'package:fts/common/http_client/intercepted_http_client.dart';
import 'package:fts/features/auth/interceptors/request/authorization_header_interceptor.dart';
import 'package:fts/main_tst.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class BackendClient {
  Cqrs? _cqrs;

  Future<Cqrs> getCqrs() async {
    if (_cqrs != null) {
      return _cqrs!;
    }

    final config = await getPatrolConfig();
    final storage = FlutterSecureCredentialsStorage();

    final httpClient = InterceptedHttpClient()
      ..addRequestInterceptor(
        AuthorizationHeaderInterceptor(
          flutterSecureCredentialsStorage: storage,
        ),
      );

    return _cqrs = Cqrs(httpClient, config.apiUri);
  }
}
