import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';
import 'package:raai/feature/medication/domain/repo/medication_repo.dart';

class CreateMedicationUseCase {
  CreateMedicationUseCase(this.medicationRepo);

  final MedicationRepo medicationRepo;
  Future<Either<ApiFailure, Unit>> call(
    InputMedicationModel inputMedicationModel,
  ) async {
    return await medicationRepo.createMedication(inputMedicationModel);
  }
}
