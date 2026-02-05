import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/medical_information/data/data_source/medical_remote_data_source.dart';
import 'package:raai/feature/medical_information/domain/repo/medical_repo.dart';

class MedicalRepoImpl extends MedicalRepo {
  MedicalRepoImpl(this.remoteDataSource);
  final MedicalRemoteDataSource remoteDataSource;
  @override
  Future<Either<ApiFailure, Unit>> setMedical({
    required Map<String, dynamic> data,
  }) async {
    try {
      await remoteDataSource.setMedical(data: data);
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
