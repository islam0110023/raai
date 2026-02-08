import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/models/domain/entity/sugar_daily_entity.dart';
import 'package:raai/feature/models/domain/repo/model_repo.dart';

class GetSugarDailyUseCase {
  GetSugarDailyUseCase(this.modelRepo);
  final ModelRepo modelRepo;

  Future<Either<ApiFailure, SugarDailyEntity>> call() {
    return modelRepo.getSugarDaily();
  }
}
