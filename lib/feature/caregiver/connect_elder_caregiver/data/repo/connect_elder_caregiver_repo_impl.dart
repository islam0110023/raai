import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/failure/dio_error_mapper.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/data/data_source/connect_elder_caregiver_remote_data_source.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/domain/repo/connect_elder_caregiver_repo.dart';

class ConnectElderCaregiverRepoImpl extends ConnectElderCaregiverRepo {
  ConnectElderCaregiverRepoImpl(this.remoteDataSource);

  final ConnectElderCaregiverRemoteDataSource remoteDataSource;
  @override
  Future<Either<ApiFailure, Unit>> connectCaregiverWithElder(
    String code,
  ) async {
    try {
      await remoteDataSource.connectCaregiverWithElder(code);
      return right(unit);
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
