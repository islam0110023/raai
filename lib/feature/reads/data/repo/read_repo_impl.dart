import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/reads/data/data_source/read_remote_data_source.dart';
import 'package:raai/feature/reads/domain/entity/blood_read_entity.dart';
import 'package:raai/feature/reads/domain/entity/sugar_read_entity.dart';
import 'package:raai/feature/reads/domain/repo/read_repo.dart';

class ReadRepoImpl extends ReadRepo {
  ReadRepoImpl(this.readRemoteDataSource);
  final ReadRemoteDataSource readRemoteDataSource;
  @override
  Future<Either<ApiFailure, List<SugarReadEntity>>> getSugarReads() async {
    try {
      final data = await readRemoteDataSource.getSugarReads();
      return right(data);
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
  Future<Either<ApiFailure, List<BloodReadEntity>>> getBloodReads() async {
    try {
      final data = await readRemoteDataSource.getBloodReads();
      return right(data);
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
  Future<Either<ApiFailure, Unit>> updateSugar({
    required String id,
    required String value,
  }) async {
    try {
      await readRemoteDataSource.updateSugar(id: id, value: value);
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
  Future<Either<ApiFailure, Unit>> updateBlood({
    required String id,
    required String systolic,
    required String diastolic,
  }) async {
    try {
      await readRemoteDataSource.updateBlood(
        id: id,
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
