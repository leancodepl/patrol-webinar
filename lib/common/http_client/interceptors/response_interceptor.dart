import 'package:http/http.dart' as http;

abstract interface class ResponseInterceptor {
  Future<http.StreamedResponse> onResponse(http.StreamedResponse response);
}
