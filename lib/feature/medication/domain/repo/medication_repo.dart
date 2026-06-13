import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/failure/failure.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';
import 'package:raai/feature/medication/domain/entities/do_not_remember_entity.dart';
import 'package:raai/feature/medication/domain/entities/medication_data_entity.dart';
import 'package:raai/feature/medication/domain/entities/tablet_model_entity.dart';

abstract class MedicationRepo {
  Future<Either<ApiFailure, Unit>> createMedication(
    InputMedicationModel inputMedicationModel,
  );
  Future<Either<ApiFailure, List<MedicationDataEntity>>> getMedications();
  Future<Either<ApiFailure, Unit>> takeMedication(int doseId);
  Future<Either<ApiFailure, Unit>> snoozeMedication(int doseId);
  Future<Either<ApiFailure, DoNotRememberEntity>> doNotRemember(
    int doseId,
    int actualRemainingPills,
  );
  Future<Either<Failure, TabletModelEntity>> tabletModel(String image);
}
