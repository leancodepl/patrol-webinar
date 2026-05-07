import 'dart:async';

import 'package:fts/common/http_client/interceptors/request_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class AuthorizationHeaderInterceptor implements RequestInterceptor {
  AuthorizationHeaderInterceptor({
    required this.flutterSecureCredentialsStorage,
  });

  final FlutterSecureCredentialsStorage flutterSecureCredentialsStorage;

  @override
  FutureOr<http.BaseRequest> beforeRequest(http.BaseRequest request) async {
    final kratosAccessToken = await flutterSecureCredentialsStorage.read();
    if (kratosAccessToken != null) {
      request.headers['Authorization'] = 'Bearer $kratosAccessToken';
    }

    return request;
  }
}
