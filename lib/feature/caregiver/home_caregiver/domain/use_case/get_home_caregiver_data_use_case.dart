import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_data_entity.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/repo/home_caregiver_repo.dart';

class GetHomeCaregiverDataUseCase {
  GetHomeCaregiverDataUseCase(this.homeCaregiverRepo);

  final HomeCaregiverRepo homeCaregiverRepo;
  Future<Either<ApiFailure, HomeCaregiverDataEntity>> call() async {
    return await homeCaregiverRepo.getHomeCaregiverData();
  }
}
