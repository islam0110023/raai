import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';
import 'package:raai/feature/medication/data/model/medication_data_model/medication_data_model.dart';
import 'package:raai/feature/medication/domain/entities/medication_data_entity.dart';

abstract class MedicationRemoteDataSource {
  Future<Unit> createMedication(InputMedicationModel inputMedicationModel);
  Future<List<MedicationDataEntity>> getMedications();
}

class MedicationRemoteDataSourceImpl extends MedicationRemoteDataSource {
  @override
  Future<Unit> createMedication(
    InputMedicationModel inputMedicationModel,
  ) async {
    await DioHelper.postFormData(
      url: Endpoints.addMedication,
      formData: await inputMedicationModel.toFormData(),
      options: Options(contentType: 'multipart/form-data'),
    );
    return unit;
  }

  @override
  Future<List<MedicationDataEntity>> getMedications() async {
    final response = await DioHelper.getData(url: Endpoints.getMedications);
    final data = ApiResponse<MedicationDataModel>.fromJson(
      response.data,
      fromJsonT: (json) => MedicationDataModel.fromJson(json),
    );
    return data.data!.toEntity();
  }
}
