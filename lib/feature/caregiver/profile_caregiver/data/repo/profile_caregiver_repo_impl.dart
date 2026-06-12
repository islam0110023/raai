import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/failure/dio_error_mapper.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/caregiver/profile_caregiver/data/data_source/profile_caregiver_remote_data_source.dart';
import 'package:raai/feature/caregiver/profile_caregiver/domain/entity/profile_caregiver_data_entity.dart';
import 'package:raai/feature/caregiver/profile_caregiver/domain/repo/profile_caregiver_repo.dart';

class ProfileCaregiverRepoImpl extends ProfileCaregiverRepo {
  ProfileCaregiverRepoImpl(this.profileCaregiverRemoteDataSource);

  final ProfileCaregiverRemoteDataSource profileCaregiverRemoteDataSource;
  @override
  Future<Either<ApiFailure, ProfileCaregiverDataEntity>>
  getProfileCaregiverData() async {
    try {
      final data = await profileCaregiverRemoteDataSource
          .getProfileCaregiverData();
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
