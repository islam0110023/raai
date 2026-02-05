import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/auth/domain/entity/otp_verify_entity.dart';
import 'package:raai/feature/auth/domain/repo/auth_repo.dart';

class OtpVerifyUseCase {
  OtpVerifyUseCase(this.authRepo);
  final AuthRepo authRepo;

  Future<Either<ApiFailure, OtpVerifyEntity>> call({
    required String email,
    required String otp,
  }) {
    return authRepo.otpVerify(email: email, otp: otp);
  }
}
