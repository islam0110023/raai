import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_data_entity.dart';

abstract class HomeCaregiverRepo {
  Future<Either<ApiFailure, HomeCaregiverDataEntity>> getHomeCaregiverData();
}
