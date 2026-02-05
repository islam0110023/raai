import 'package:dio/dio.dart';
import 'package:raai/core/services/token_manager.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.tokenManager);
  final TokenManager tokenManager;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = tokenManager.accessToken;

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }
}
