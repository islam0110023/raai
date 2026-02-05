import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/auth/domain/entity/select_role_entity.dart';
import 'package:raai/feature/auth/domain/repo/auth_repo.dart';

class SelectRoleUseCase {
  SelectRoleUseCase(this.authRepo);

  final AuthRepo authRepo;
  Future<Either<ApiFailure, SelectRoleEntity>> call({required String role}) {
    return authRepo.selectRole(role: role);
  }
}
