import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';

abstract class PersonalRepo {
  Future<Either<ApiFailure, Unit>> setPersonalInfo({
    required String gender,
    required String birthDate,
    required String firstName,
    required String lastName,
  });
}
