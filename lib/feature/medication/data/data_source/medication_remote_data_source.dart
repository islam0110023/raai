import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/medication/data/model/do_not_remember_model.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';
import 'package:raai/feature/medication/data/model/medication_data_model/medication_data_model.dart';
import 'package:raai/feature/medication/domain/entities/do_not_remember_entity.dart';
import 'package:raai/feature/medication/domain/entities/medication_data_entity.dart';
import 'package:raai/feature/medication/domain/entities/tablet_model_entity.dart';

abstract class MedicationRemoteDataSource {
  Future<Unit> createMedication(InputMedicationModel inputMedicationModel);
  Future<List<MedicationDataEntity>> getMedications();
  Future<Unit> takeMedication(int doseId);
  Future<Unit> snoozeMedication(int doseId);
  Future<DoNotRememberEntity> doNotRemember(
    int doseId,
    int actualRemainingPills,
  );
  Future<TabletModelEntity> tabletModel(String image);
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

  @override
  Future<Unit> takeMedication(int doseId) async {
    await DioHelper.patchData(url: Endpoints.takeMedication(doseId));
    return unit;
  }

  @override
  Future<Unit> snoozeMedication(int doseId) async {
    await DioHelper.patchData(url: Endpoints.snoozeMedication(doseId));
    return unit;
  }

  @override
  Future<DoNotRememberEntity> doNotRemember(
    int doseId,
    int actualRemainingPills,
  ) async {
    final response = await DioHelper.postData(
      url: Endpoints.doNotRemember(doseId),
      data: {'actualRemainingPills': actualRemainingPills},
    );
    final data = ApiResponse<DoNotRememberModel>.fromJson(
      response.data,
      fromJsonT: (json) => DoNotRememberModel.fromJson(json),
    );
    return data.data!.toEntity();
  }

  @override
  Future<TabletModelEntity> tabletModel(String image) async {
    final response = await DioHelper.postFormData(
      url: Endpoints.tabletModel,
      formData: FormData.fromMap({'file': image}),
      options: Options(contentType: 'multipart/form-data'),
    );
    return TabletModelEntity.fromJson(response.data);
  }
}
