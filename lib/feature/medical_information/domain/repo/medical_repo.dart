import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';

abstract class MedicalRepo {
  Future<Either<ApiFailure, Unit>> setMedical({
    required Map<String, dynamic> data,
  });
}
