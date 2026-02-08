import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/profile/domain/entity/profile_user_entity.dart';

abstract class ProfileRepo {
  Future<Either<ApiFailure, ProfileUserEntity>> getUserProfile();
}
