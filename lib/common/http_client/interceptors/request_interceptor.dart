import 'dart:async';

import 'package:http/http.dart' as http;

abstract interface class RequestInterceptor {
  FutureOr<http.BaseRequest> beforeRequest(http.BaseRequest request);
}
