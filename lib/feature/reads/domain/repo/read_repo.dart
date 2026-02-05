import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/reads/domain/entity/blood_read_entity.dart';
import 'package:raai/feature/reads/domain/entity/sugar_read_entity.dart';

abstract class ReadRepo {
  Future<Either<ApiFailure, List<SugarReadEntity>>> getSugarReads();
  Future<Either<ApiFailure, List<BloodReadEntity>>> getBloodReads();
  Future<Either<ApiFailure, Unit>> updateSugar({
    required String id,
    required String value,
  });
  Future<Either<ApiFailure, Unit>> updateBlood({
    required String id,
    required String systolic,
    required String diastolic,
  });
}
