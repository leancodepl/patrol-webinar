import 'package:fts/common/http_client/interceptors/request_interceptor.dart';
import 'package:fts/common/http_client/interceptors/response_interceptor.dart';

abstract interface class RequestResponseInterceptor
    implements RequestInterceptor, ResponseInterceptor {}
