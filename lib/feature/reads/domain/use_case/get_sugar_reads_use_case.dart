import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/reads/domain/entity/sugar_read_entity.dart';
import 'package:raai/feature/reads/domain/repo/read_repo.dart';

class GetSugarReadsUseCase {
  GetSugarReadsUseCase(this.readRepo);

  final ReadRepo readRepo;
  Future<Either<ApiFailure, List<SugarReadEntity>>> call() {
    return readRepo.getSugarReads();
  }
}
