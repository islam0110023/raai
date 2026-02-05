import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/auth/domain/entity/reset_entity.dart';
import 'package:raai/feature/auth/domain/repo/auth_repo.dart';

class ResetPassUseCase {
  ResetPassUseCase(this.authRepo);
  final AuthRepo authRepo;

  Future<Either<ApiFailure, ResetEntity>> call({required String email}) {
    return authRepo.resetPass(email: email);
  }
}
