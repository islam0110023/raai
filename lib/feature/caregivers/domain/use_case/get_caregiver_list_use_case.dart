import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/caregivers/domain/entity/caregiver_list_entity.dart';
import 'package:raai/feature/caregivers/domain/repo/caregiver_repo.dart';

class GetCaregiverListUseCase {
  GetCaregiverListUseCase(this.caregiverRepo);

  final CaregiverRepo caregiverRepo;
  Future<Either<ApiFailure, List<CaregiverListEntity>>> call() {
    return caregiverRepo.getCaregiverList();
  }
}
