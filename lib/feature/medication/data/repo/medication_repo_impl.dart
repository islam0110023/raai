import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/failure/dio_error_mapper.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/medication/data/data_source/medication_remote_data_source.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';
import 'package:raai/feature/medication/domain/entities/medication_data_entity.dart';
import 'package:raai/feature/medication/domain/repo/medication_repo.dart';

class MedicationRepoImpl extends MedicationRepo {
  MedicationRepoImpl(this.medicationRemoteDataSource);

  final MedicationRemoteDataSource medicationRemoteDataSource;
  @override
  Future<Either<ApiFailure, Unit>> createMedication(
    InputMedicationModel inputMedicationModel,
  ) async {
    try {
      await medicationRemoteDataSource.createMedication(inputMedicationModel);
      return const Right(unit);
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

  @override
  Future<Either<ApiFailure, List<MedicationDataEntity>>>
  getMedications() async {
    try {
      final data = await medicationRemoteDataSource.getMedications();
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
