import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/entity/all_medication_in_caregiver_entity.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/repo/all_medication_caregiver_repo.dart';

class GetAllMedicationInCaregiverUseCase {
  GetAllMedicationInCaregiverUseCase(this.allMedicationCaregiverRepo);

  final AllMedicationCaregiverRepo allMedicationCaregiverRepo;
  Future<Either<ApiFailure, AllMedicationInCaregiverEntity>> call() {
    return allMedicationCaregiverRepo.getAllMedicationInCaregiver();
  }
}
