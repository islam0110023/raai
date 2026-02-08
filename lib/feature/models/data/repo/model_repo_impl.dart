import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/failure/dio_error_mapper.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/models/data/data_source/model_remote_data_source.dart';
import 'package:raai/feature/models/domain/entity/sugar_daily_entity.dart';
import 'package:raai/feature/models/domain/entity/sugar_monthly_entity.dart';
import 'package:raai/feature/models/domain/repo/model_repo.dart';

class ModelRepoImpl extends ModelRepo {
  ModelRepoImpl(this.modelRemoteDataSource);

  final ModelRemoteDataSource modelRemoteDataSource;
  @override
  Future<Either<ApiFailure, SugarMonthlyEntity>> getSugarMonthly() async {
    try {
      final data = await modelRemoteDataSource.getSugarMonthly();
      return right(data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(DioErrorMapper.map(e));
    } catch (e) {
      return left(ServerFailure(null));
    }
  }

  @override
  Future<Either<ApiFailure, SugarDailyEntity>> getSugarDaily() async {
    try {
      final data = await modelRemoteDataSource.getSugarDaily();
      return right(data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(DioErrorMapper.map(e));
    } catch (e) {
      return left(ServerFailure(null));
    }
  }
}
