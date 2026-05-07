import 'package:fts/common/http_client/interceptors/response_interceptor.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:http/http.dart' as http;

class UnauthorizedInterceptor implements ResponseInterceptor {
  UnauthorizedInterceptor({required this.authCubit});

  final AuthCubit authCubit;

  @override
  Future<http.StreamedResponse> onResponse(
    http.StreamedResponse response,
  ) async {
    if (response.statusCode == 401) {
      await authCubit.logout();
    }

    return response;
  }
}
