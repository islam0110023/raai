import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/domain/repo/connect_elder_caregiver_repo.dart';

class ConnectCaregiverWithElderUseCase {
  ConnectCaregiverWithElderUseCase(this.connectElderCaregiverRepo);

  final ConnectElderCaregiverRepo connectElderCaregiverRepo;
  Future<Either<ApiFailure, Unit>> call(String code) async {
    return await connectElderCaregiverRepo.connectCaregiverWithElder(code);
  }
}
