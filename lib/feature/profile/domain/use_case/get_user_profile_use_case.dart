import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/profile/domain/entity/profile_user_entity.dart';
import 'package:raai/feature/profile/domain/repo/profile_repo.dart';

class GetUserProfileUseCase {
  GetUserProfileUseCase(this.profileRepo);

  final ProfileRepo profileRepo;

  Future<Either<ApiFailure, ProfileUserEntity>> call() {
    return profileRepo.getUserProfile();
  }
}
