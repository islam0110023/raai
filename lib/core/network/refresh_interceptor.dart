import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/core/secure_storage/secure_storage.dart';
import 'package:raai/core/services/token_manager.dart';
import 'package:raai/feature/auth/domain/use_case/refresh_access_token_use_case.dart';

class RefreshInterceptor extends Interceptor {
  RefreshInterceptor(
    this.tokenManager,
    this.refreshAccessTokenUseCase, {
    required this.onForceLogout,
  });

  final TokenManager tokenManager;
  final RefreshAccessTokenUseCase refreshAccessTokenUseCase;
  final VoidCallback onForceLogout;

  bool isRefreshing = false;
  final List<Future<void> Function()> retryQueue = [];
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final request = err.requestOptions;
    if (request.extra['skipAuth'] == true) {
      return handler.next(err);
    }
    if (request.extra['isRetry'] == true) {
      return handler.next(err);
    }

    final refreshToken = await SecureStorage.getUserToken();
    if (refreshToken == null) {
      forceLogout();
      return handler.next(err);
    }
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      if (isRefreshing) {
        retryQueue.add(() async {
          handler.resolve(await retry(err.requestOptions));
        });
        return;
      }
      isRefreshing = true;
      try {
        final result = await refreshAccessTokenUseCase.call(
          refreshToken: refreshToken,
        );

        result.fold(
          (failure) {
            throw failure;
          },
          (entity) async {
            tokenManager.saveAccessToken(entity.accessToken);
            await SecureStorage.saveUserToken(token: entity.refreshToken);
          },
        );
        for (final retry in retryQueue) {
          await retry();
        }
        retryQueue.clear();

        handler.resolve(await retry(err.requestOptions));
      } catch (_) {
        forceLogout();
      } finally {
        isRefreshing = false;
      }
    } else {
      handler.next(err);
    }
  }

  Future<Response> retry(RequestOptions requestOptions) {
    final dio = DioHelper.dio;
    requestOptions.headers['Authorization'] =
        'Bearer ${tokenManager.accessToken}';
    requestOptions.headers['Accept'] = 'application/json';
    requestOptions.extra['isRetry'] = true;

    return dio.fetch(requestOptions);
  }

  void forceLogout() {
    // tokenManager.clear();
    // await SecureStorage.clear();
    // await CacheHelper.removeData(key: AppConstant.cacheKeyIsLoggedIn);
    // getIt<AuthCubit>().logout();
    onForceLogout();

    // emit logout / navigate to login
  }
}
