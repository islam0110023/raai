import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';
import 'package:raai/feature/medication/domain/entities/medication_data_entity.dart';

abstract class MedicationRepo {
  Future<Either<ApiFailure, Unit>> createMedication(
    InputMedicationModel inputMedicationModel,
  );
  Future<Either<ApiFailure, List<MedicationDataEntity>>> getMedications();
}
