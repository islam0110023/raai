import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/core/failure/dio_error_mapper.dart';
import 'package:raai/core/failure/failure.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/feature/medication/data/data_source/medication_remote_data_source.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';
import 'package:raai/feature/medication/domain/entities/do_not_remember_entity.dart';
import 'package:raai/feature/medication/domain/entities/medication_data_entity.dart';
import 'package:raai/feature/medication/domain/entities/tablet_model_entity.dart';
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

  @override
  Future<Either<ApiFailure, Unit>> takeMedication(int doseId) async {
    try {
      await medicationRemoteDataSource.takeMedication(doseId);
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
  Future<Either<ApiFailure, Unit>> snoozeMedication(int doseId) async {
    try {
      await medicationRemoteDataSource.snoozeMedication(doseId);
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
  Future<Either<ApiFailure, DoNotRememberEntity>> doNotRemember(
    int doseId,
    int actualRemainingPills,
  ) async {
    try {
      final data = await medicationRemoteDataSource.doNotRemember(
        doseId,
        actualRemainingPills,
      );
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

  @override
  Future<Either<Failure, TabletModelEntity>> tabletModel(String image) async {
    try {
      final data = await medicationRemoteDataSource.tabletModel(image);
      return Right(data);
    } on DioException catch (e) {
      return left(
        Failure(ApiErrorMapper.getArabicMessage(DioErrorMapper.map(e) as int?)),
      );
    } catch (e) {
      return left(Failure(ApiErrorMapper.getArabicMessage(null)));
    }
  }
}
