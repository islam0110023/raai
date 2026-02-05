import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/auth/domain/repo/auth_repo.dart';

class RegisterUseCase {
  RegisterUseCase(this.authRepo);
  final AuthRepo authRepo;
  Future<Either<ApiFailure, Unit>> call({
    required String email,

    required String phone,

    required String password,
  }) {
    return authRepo.register(email: email, phone: phone, password: password);
  }
}
