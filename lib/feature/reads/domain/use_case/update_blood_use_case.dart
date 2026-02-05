import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/reads/domain/repo/read_repo.dart';

class UpdateBloodUseCase {
  UpdateBloodUseCase(this.readRepo);
  final ReadRepo readRepo;
  Future<Either<ApiFailure, Unit>> call({
    required String id,

    required String systolic,

    required String diastolic,
  }) {
    return readRepo.updateBlood(
      id: id,
      systolic: systolic,
      diastolic: diastolic,
    );
  }
}
