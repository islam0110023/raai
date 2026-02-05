import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';

abstract class AddReadRepo {
  Future<Either<ApiFailure, Unit>> addSugar({required String sugar});
  Future<Either<ApiFailure, Unit>> addBlood({
    required String systolic,
    required String diastolic,
  });
}
