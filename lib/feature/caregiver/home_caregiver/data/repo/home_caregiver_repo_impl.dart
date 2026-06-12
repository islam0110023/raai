import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/failure/dio_error_mapper.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/caregiver/home_caregiver/data/data_source/home_caregiver_remote_data_source.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_data_entity.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/repo/home_caregiver_repo.dart';

class HomeCaregiverRepoImpl extends HomeCaregiverRepo {
  HomeCaregiverRepoImpl(this.homeCaregiverRemoteDataSource);

  final HomeCaregiverRemoteDataSource homeCaregiverRemoteDataSource;
  @override
  Future<Either<ApiFailure, HomeCaregiverDataEntity>>
  getHomeCaregiverData() async {
    try {
      final data = await homeCaregiverRemoteDataSource.getHomeCaregiverData();
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
