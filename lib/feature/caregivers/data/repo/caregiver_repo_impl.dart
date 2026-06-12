import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/failure/dio_error_mapper.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/caregivers/data/data_source/caregiver_remote_data_source.dart';
import 'package:raai/feature/caregivers/domain/entity/caregiver_list_entity.dart';
import 'package:raai/feature/caregivers/domain/repo/caregiver_repo.dart';

class CaregiverRepoImpl extends CaregiverRepo {
  CaregiverRepoImpl(this.caregiverRemoteDataSource);

  final CaregiverRemoteDataSource caregiverRemoteDataSource;
  @override
  Future<Either<ApiFailure, List<CaregiverListEntity>>>
  getCaregiverList() async {
    try {
      final data = await caregiverRemoteDataSource.getCaregiverList();
      return Right(data);
    } on DioException catch (e) {
      print(e.toString());
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final response = ApiResponse.fromJson(data);
        return left(ServerFailure(response.appCode));
      }

      return left(DioErrorMapper.map(e));
    } catch (e) {
      print(e.toString());
      return left(ServerFailure(null));
    }
  }
}
