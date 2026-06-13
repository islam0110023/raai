import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/medication/domain/repo/medication_repo.dart';

class SnoozeMedicationUseCase {
  SnoozeMedicationUseCase(this.medicationRepo);

  final MedicationRepo medicationRepo;
  Future<Either<ApiFailure, Unit>> call(int doseId) {
    return medicationRepo.snoozeMedication(doseId);
  }
}
