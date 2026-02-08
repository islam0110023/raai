import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/failure/dio_error_mapper.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/profile/data/data_source/profile_remote_data_source.dart';
import 'package:raai/feature/profile/domain/entity/profile_user_entity.dart';
import 'package:raai/feature/profile/domain/repo/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  ProfileRepoImpl(this.remoteDataSource);

  final ProfileRemoteDataSource remoteDataSource;
  @override
  Future<Either<ApiFailure, ProfileUserEntity>> getUserProfile() async {
    try {
      final data = await remoteDataSource.getUserProfile();
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
