import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/medication/domain/entities/do_not_remember_entity.dart';
import 'package:raai/feature/medication/domain/repo/medication_repo.dart';

class DoNotRememberUseCase {
  DoNotRememberUseCase(this.repo);

  final MedicationRepo repo;
  Future<Either<ApiFailure, DoNotRememberEntity>> call(
    int doseId,
    int actualRemainingPills,
  ) async {
    return await repo.doNotRemember(doseId, actualRemainingPills);
  }
}
