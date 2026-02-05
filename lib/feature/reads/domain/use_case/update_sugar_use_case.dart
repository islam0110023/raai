import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/reads/domain/repo/read_repo.dart';

class UpdateSugarUseCase {
  UpdateSugarUseCase(this.readRepo);

  final ReadRepo readRepo;
  Future<Either<ApiFailure, Unit>> call({
    required String id,
    required String value,
  }) {
    return readRepo.updateSugar(id: id, value: value);
  }
}
