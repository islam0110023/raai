import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/auth/domain/repo/auth_repo.dart';

class NewPasswordUseCase {
  NewPasswordUseCase(this.authRepo);
  final AuthRepo authRepo;
  Future<Either<ApiFailure, Unit>> call({
    required String resetToken,
    required String password,
  }) {
    return authRepo.newPassword(resetToken: resetToken, password: password);
  }
}
