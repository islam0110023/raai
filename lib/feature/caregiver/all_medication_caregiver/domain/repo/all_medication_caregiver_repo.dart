import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/entity/all_medication_in_caregiver_entity.dart';

abstract class AllMedicationCaregiverRepo {
  Future<Either<ApiFailure, AllMedicationInCaregiverEntity>>
  getAllMedicationInCaregiver();
}
