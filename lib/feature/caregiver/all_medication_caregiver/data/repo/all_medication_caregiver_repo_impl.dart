import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/failure/dio_error_mapper.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/data/data_source/all_medication_caregiver_remote_data_source.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/entity/all_medication_in_caregiver_entity.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/repo/all_medication_caregiver_repo.dart';

class AllMedicationCaregiverRepoImpl extends AllMedicationCaregiverRepo {
  AllMedicationCaregiverRepoImpl(this.remoteDataSource);
  final AllMedicationCaregiverRemoteDataSource remoteDataSource;
  @override
  Future<Either<ApiFailure, AllMedicationInCaregiverEntity>>
  getAllMedicationInCaregiver() async {
    try {
      final data = await remoteDataSource.getAllMedicationInCaregiver();
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
