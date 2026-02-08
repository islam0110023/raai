import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/models/domain/entity/sugar_monthly_entity.dart';
import 'package:raai/feature/models/domain/repo/model_repo.dart';

class GetSugarMonthlyUseCase {
  GetSugarMonthlyUseCase(this.modelRepo);
  final ModelRepo modelRepo;

  Future<Either<ApiFailure, SugarMonthlyEntity>> call() {
    return modelRepo.getSugarMonthly();
  }
}
