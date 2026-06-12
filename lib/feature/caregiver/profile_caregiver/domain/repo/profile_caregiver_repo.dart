import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/caregiver/profile_caregiver/domain/entity/profile_caregiver_data_entity.dart';

abstract class ProfileCaregiverRepo {
  Future<Either<ApiFailure, ProfileCaregiverDataEntity>>
  getProfileCaregiverData();
}
