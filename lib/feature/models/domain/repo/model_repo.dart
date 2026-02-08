import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/models/domain/entity/sugar_daily_entity.dart';
import 'package:raai/feature/models/domain/entity/sugar_monthly_entity.dart';

abstract class ModelRepo {
  Future<Either<ApiFailure, SugarMonthlyEntity>> getSugarMonthly();
  Future<Either<ApiFailure, SugarDailyEntity>> getSugarDaily();
}
