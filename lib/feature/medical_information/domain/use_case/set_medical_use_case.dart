import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/api_failure.dart';
import 'package:raai/feature/medical_information/domain/repo/medical_repo.dart';

class SetMedicalUseCase {
  SetMedicalUseCase(this.medicalRepo);
  final MedicalRepo medicalRepo;
  Future<Either<ApiFailure, int>> call({
    required Map<String, dynamic> data,
    int? elderId,
  }) {
    return medicalRepo.setMedical(data: data, elderId: elderId);
  }
}
