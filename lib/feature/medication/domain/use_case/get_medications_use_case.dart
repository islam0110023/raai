import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/medication/domain/entities/medication_data_entity.dart';
import 'package:raai/feature/medication/domain/repo/medication_repo.dart';

class GetMedicationsUseCase {
  GetMedicationsUseCase(this.medicationRepo);

  final MedicationRepo medicationRepo;

  Future<Either<ApiFailure, List<MedicationDataEntity>>> call() async {
    return await medicationRepo.getMedications();
  }
}
