import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/failure.dart';
import 'package:raai/feature/medication/domain/entities/tablet_model_entity.dart';
import 'package:raai/feature/medication/domain/repo/medication_repo.dart';

class TabletModelUseCase {
  TabletModelUseCase(this.repo);

  final MedicationRepo repo;
  Future<Either<Failure, TabletModelEntity>> call(String image) async {
    return await repo.tabletModel(image);
  }
}
