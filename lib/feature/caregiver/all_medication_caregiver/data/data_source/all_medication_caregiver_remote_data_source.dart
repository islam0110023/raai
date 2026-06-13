import 'package:raai/core/model/api_response.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/data/model/all_medication_elder_in_caregiver/all_medication_elder_in_caregiver_model.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/entity/all_medication_in_caregiver_entity.dart';

abstract class AllMedicationCaregiverRemoteDataSource {
  Future<AllMedicationInCaregiverEntity> getAllMedicationInCaregiver();
}

class AllMedicationCaregiverRemoteDataSourceImpl
    extends AllMedicationCaregiverRemoteDataSource {
  @override
  Future<AllMedicationInCaregiverEntity> getAllMedicationInCaregiver() async {
    final response = await DioHelper.getData(
      url: Endpoints.allMedicationInCaregiver,
    );
    final data = ApiResponse<AllMedicationElderInCaregiverModel>.fromJson(
      response.data,
      fromJsonT: (json) => AllMedicationElderInCaregiverModel.fromJson(json),
    );
    return data.data!.toEntity();
  }
}
