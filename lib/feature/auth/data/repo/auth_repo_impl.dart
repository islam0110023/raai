import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/auth/data/data_source/auth_remote_data_source.dart';
import 'package:raai/feature/auth/domain/entity/login_entity.dart';
import 'package:raai/feature/auth/domain/entity/otp_reset_entity.dart';
import 'package:raai/feature/auth/domain/entity/otp_verify_entity.dart';
import 'package:raai/feature/auth/domain/entity/reset_entity.dart';
import 'package:raai/feature/auth/domain/entity/select_role_entity.dart';
import 'package:raai/feature/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl(this.authRemoteDataSource);
  final AuthRemoteDataSource authRemoteDataSource;
  @override
  Future<Either<ApiFailure, Unit>> register({
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      await authRemoteDataSource.register(
        email: email,
        phone: phone,
        password: password,
      );
      return right(unit);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(ServerFailure(999));
    } catch (e) {
      return left(ServerFailure(null));
    }
  }

  @override
  Future<Either<ApiFailure, OtpVerifyEntity>> otpVerify({
    required String email,
    required String otp,
  }) async {
    try {
      final data = await authRemoteDataSource.otpVerify(email: email, otp: otp);
      return right(data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(ServerFailure(999));
    } catch (e) {
      return left(ServerFailure(null));
    }
  }

  @override
  Future<Either<ApiFailure, OtpVerifyEntity>> refreshAccessToken({
    required String refreshToken,
  }) async {
    try {
      final data = await authRemoteDataSource.refreshAccessToken(
        refreshToken: refreshToken,
      );
      return right(data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(ServerFailure(999));
    } catch (e) {
      return left(ServerFailure(null));
    }
  }

  @override
  Future<Either<ApiFailure, LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await authRemoteDataSource.login(
        email: email,
        password: password,
      );
      return right(data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(ServerFailure(999));
    } catch (e) {
      return left(ServerFailure(null));
    }
  }

  @override
  Future<Either<ApiFailure, ResetEntity>> resetPass({
    required String email,
  }) async {
    try {
      final data = await authRemoteDataSource.resetPass(email: email);
      return right(data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(ServerFailure(999));
    } catch (e) {
      return left(ServerFailure(null));
    }
  }

  @override
  Future<Either<ApiFailure, OtpResetEntity>> otpReset({
    required int resetRequestId,
    required String otp,
  }) async {
    try {
      final data = await authRemoteDataSource.otpReset(
        resetRequestId: resetRequestId,
        otp: otp,
      );
      return right(data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(ServerFailure(999));
    } catch (e) {
      return left(ServerFailure(null));
    }
  }

  @override
  Future<Either<ApiFailure, Unit>> newPassword({
    required String resetToken,
    required String password,
  }) async {
    try {
      await authRemoteDataSource.newPassword(
        resetToken: resetToken,
        password: password,
      );
      return right(unit);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(ServerFailure(999));
    } catch (e) {
      return left(ServerFailure(null));
    }
  }

  @override
  Future<Either<ApiFailure, SelectRoleEntity>> selectRole({
    required String role,
  }) async {
    try {
      final data = await authRemoteDataSource.selectRole(role: role);
      return right(data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(ServerFailure(999));
    } catch (e) {
      return left(ServerFailure(null));
    }
  }
}
