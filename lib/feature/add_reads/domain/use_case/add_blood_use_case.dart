import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/add_reads/domain/repo/add_read_repo.dart';

class AddBloodUseCase {
  AddBloodUseCase(this.addReadRepo);
  final AddReadRepo addReadRepo;

  Future<Either<ApiFailure, Unit>> call({
    required String systolic,
    required String diastolic,
  }) {
    return addReadRepo.addBlood(systolic: systolic, diastolic: diastolic);
  }
}
