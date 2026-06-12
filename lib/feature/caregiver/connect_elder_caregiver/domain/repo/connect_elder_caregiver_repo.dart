import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';

abstract class ConnectElderCaregiverRepo {
  Future<Either<ApiFailure, Unit>> connectCaregiverWithElder(String code);
}
