import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/caregiver/profile_caregiver/domain/entity/profile_caregiver_data_entity.dart';
import 'package:raai/feature/caregiver/profile_caregiver/domain/repo/profile_caregiver_repo.dart';

class GetProfileCaregiverDataUseCase {
  GetProfileCaregiverDataUseCase(this.profileCaregiverRepo);

  final ProfileCaregiverRepo profileCaregiverRepo;
  Future<Either<ApiFailure, ProfileCaregiverDataEntity>> call() {
    return profileCaregiverRepo.getProfileCaregiverData();
  }
}
