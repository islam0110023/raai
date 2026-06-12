import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/caregivers/domain/entity/caregiver_list_entity.dart';

abstract class CaregiverRepo {
  Future<Either<ApiFailure, List<CaregiverListEntity>>> getCaregiverList();
}
