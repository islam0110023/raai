import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/add_reads/data/data_source/add_read_remote_data_source.dart';
import 'package:raai/feature/add_reads/domain/repo/add_read_repo.dart';

class AddReadRepoImpl extends AddReadRepo {
  AddReadRepoImpl(this.addReadRemoteDataSource);

  final AddReadRemoteDataSource addReadRemoteDataSource;
  @override
  Future<Either<ApiFailure, Unit>> addSugar({required String sugar}) async {
    try {
      await addReadRemoteDataSource.addSugar(sugar: sugar);
      return right(unit);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(ServerFailure(999));
    } catch (e) {
      return left(ServerFailure(null));
    }
  }

  @override
  Future<Either<ApiFailure, Unit>> addBlood({
    required String systolic,
    required String diastolic,
  }) async {
    try {
      await addReadRemoteDataSource.addBlood(
        systolic: systolic,
        diastolic: diastolic,
      );
      return right(unit);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(ServerFailure(999));
    } catch (e) {
      return left(ServerFailure(null));
    }
  }
}
