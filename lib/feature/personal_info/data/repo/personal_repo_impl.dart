import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/failure/dio_error_mapper.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/personal_info/data/data_source/personal_remote_data_source.dart';
import 'package:raai/feature/personal_info/domain/repo/personal_repo.dart';

class PersonalRepoImpl extends PersonalRepo {
  PersonalRepoImpl(this.personalRemoteDataSource);

  final PersonalRemoteDataSource personalRemoteDataSource;
  @override
  Future<Either<ApiFailure, Unit>> setPersonalInfo({
    required String gender,
    required String birthDate,
    required String firstName,
    required String lastName,
  }) async {
    try {
      await personalRemoteDataSource.setPersonalInfo(
        gender: gender,
        birthDate: birthDate,
        firstName: firstName,
        lastName: lastName,
      );
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
