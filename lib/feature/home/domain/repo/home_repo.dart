import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/home/domain/entities/home_data_entity.dart';

abstract class HomeRepo {
  Future<Either<ApiFailure, HomeDataEntity>> getHomeData();
}
