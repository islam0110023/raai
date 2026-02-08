import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/db/cache_helper/cache_helper.dart';
import 'package:raai/core/secure_storage/secure_storage.dart';
import 'package:raai/core/services/token_manager.dart';
import 'package:raai/core/utils/constants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.tokenManager) : super(AuthInitial());
  final TokenManager tokenManager;
  void checkAuth() {
    if (tokenManager.isLoggedIn) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  void clear() async {
    tokenManager.clear();
    await SecureStorage.clear();
    await CacheHelper.removeData(key: AppConstant.cacheKeyIsLoggedIn);
    await CacheHelper.removeData(key: AppConstant.cacheKeyCaregiverIsLoggedIn);
    emit(AuthUnauthenticated());
  }

  void logout() async {
    emit(AuthLoading());
    tokenManager.clear();
    await SecureStorage.clear();
    await CacheHelper.removeData(key: AppConstant.cacheKeyIsLoggedIn);
    await CacheHelper.removeData(key: AppConstant.cacheKeyCaregiverIsLoggedIn);
    emit(AuthUnauthenticated());
  }
}
