import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/failure/dio_error_mapper.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:raai/feature/home/domain/entities/home_data_entity.dart';
import 'package:raai/feature/home/domain/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl(this.homeRemoteDataSource);

  final HomeRemoteDataSource homeRemoteDataSource;
  @override
  Future<Either<ApiFailure, HomeDataEntity>> getHomeData() async {
    try {
      final data = await homeRemoteDataSource.getHomeData();
      return Right(data);
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
