import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/auth/domain/entity/otp_reset_entity.dart';
import 'package:raai/feature/auth/domain/repo/auth_repo.dart';

class OtpResetUseCase {
  OtpResetUseCase(this.authRepo);
  final AuthRepo authRepo;

  Future<Either<ApiFailure, OtpResetEntity>> call({
    required int resetRequestId,
    required String otp,
  }) {
    return authRepo.otpReset(resetRequestId: resetRequestId, otp: otp);
  }
}
