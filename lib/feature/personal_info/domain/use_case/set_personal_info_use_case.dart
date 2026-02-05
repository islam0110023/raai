import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/personal_info/domain/repo/personal_repo.dart';

class SetPersonalInfoUseCase {
  SetPersonalInfoUseCase(this.personalRepo);

  final PersonalRepo personalRepo;
  Future<Either<ApiFailure, Unit>> call({
    required String gender,
    required String birthDate,
    required String firstName,
    required String lastName,
  }) {
    return personalRepo.setPersonalInfo(
      gender: gender,
      birthDate: birthDate,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
