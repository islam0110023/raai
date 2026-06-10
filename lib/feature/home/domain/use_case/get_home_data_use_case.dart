import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/home/domain/entities/home_data_entity.dart';
import 'package:raai/feature/home/domain/repo/home_repo.dart';

class GetHomeDataUseCase {
  GetHomeDataUseCase(this.homeRepo);
  final HomeRepo homeRepo;
  Future<Either<ApiFailure, HomeDataEntity>> call() async {
    return await homeRepo.getHomeData();
  }
}
