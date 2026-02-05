import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/auth/domain/entity/login_entity.dart';
import 'package:raai/feature/auth/domain/entity/otp_reset_entity.dart';
import 'package:raai/feature/auth/domain/entity/otp_verify_entity.dart';
import 'package:raai/feature/auth/domain/entity/reset_entity.dart';
import 'package:raai/feature/auth/domain/entity/select_role_entity.dart';

abstract class AuthRepo {
  Future<Either<ApiFailure, Unit>> register({
    required String email,
    required String phone,
    required String password,
  });
  Future<Either<ApiFailure, OtpVerifyEntity>> otpVerify({
    required String email,
    required String otp,
  });
  Future<Either<ApiFailure, OtpVerifyEntity>> refreshAccessToken({
    required String refreshToken,
  });
  Future<Either<ApiFailure, LoginEntity>> login({
    required String email,
    required String password,
  });
  Future<Either<ApiFailure, ResetEntity>> resetPass({required String email});
  Future<Either<ApiFailure, OtpResetEntity>> otpReset({
    required int resetRequestId,
    required String otp,
  });
  Future<Either<ApiFailure, Unit>> newPassword({
    required String resetToken,
    required String password,
  });
  Future<Either<ApiFailure, SelectRoleEntity>> selectRole({
    required String role,
  });
}
