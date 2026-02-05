import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/auth/domain/entity/login_entity.dart';
import 'package:raai/feature/auth/domain/repo/auth_repo.dart';

class LoginUseCase {
  LoginUseCase(this.authRepo);
  final AuthRepo authRepo;
  Future<Either<ApiFailure, LoginEntity>> call({
    required String email,

    required String password,
  }) {
    return authRepo.login(email: email, password: password);
  }
}
