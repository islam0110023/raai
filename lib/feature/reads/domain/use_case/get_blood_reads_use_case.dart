import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/reads/domain/entity/blood_read_entity.dart';
import 'package:raai/feature/reads/domain/repo/read_repo.dart';

class GetBloodReadsUseCase {
  GetBloodReadsUseCase(this.readRepo);

  final ReadRepo readRepo;
  Future<Either<ApiFailure, List<BloodReadEntity>>> call() {
    return readRepo.getBloodReads();
  }
}
