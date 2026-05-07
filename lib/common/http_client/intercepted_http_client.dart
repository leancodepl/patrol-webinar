import 'package:fts/common/http_client/create_client.dart'
    if (dart.library.js_interop) 'create_browser_client.dart';
import 'package:fts/common/http_client/interceptors/interceptor.dart';
import 'package:fts/common/http_client/interceptors/request_interceptor.dart';
import 'package:fts/common/http_client/interceptors/response_interceptor.dart';
import 'package:http/http.dart' as http;

class InterceptedHttpClient extends http.BaseClient {
  final http.Client _inner = createHttpClient();

  final responseInterceptors = <ResponseInterceptor>[];
  final requestInterceptors = <RequestInterceptor>[];

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    var interceptedRequest = request;

    for (final interceptor in requestInterceptors) {
      final modifiedRequest = await interceptor.beforeRequest(
        interceptedRequest,
      );
      interceptedRequest = modifiedRequest;
    }

    final response = await _inner.send(interceptedRequest);

    var interceptedResponse = response;

    for (final interceptor in responseInterceptors) {
      final modifiedResponse = await interceptor.onResponse(
        interceptedResponse,
      );
      interceptedResponse = modifiedResponse;
    }

    return interceptedResponse;
  }

  void addInterceptor(RequestResponseInterceptor interceptor) {
    requestInterceptors.add(interceptor);
    responseInterceptors.add(interceptor);
  }

  void removeInterceptor(RequestResponseInterceptor interceptor) {
    requestInterceptors.remove(interceptor);
    responseInterceptors.remove(interceptor);
  }

  void addRequestInterceptor(RequestInterceptor requestInterceptor) {
    requestInterceptors.add(requestInterceptor);
  }

  void removeRequestInterceptor(RequestInterceptor requestInterceptor) {
    requestInterceptors.remove(requestInterceptor);
  }

  void addResponseInterceptor(ResponseInterceptor responseInterceptor) {
    responseInterceptors.add(responseInterceptor);
  }

  void removeResponseInterceptor(ResponseInterceptor responseInterceptor) {
    responseInterceptors.remove(responseInterceptor);
  }
}
