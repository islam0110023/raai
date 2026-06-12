import 'package:raai/core/model/api_response.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/caregiver/profile_caregiver/data/model/profile_caregiver_model/profile_caregiver_model.dart';
import 'package:raai/feature/caregiver/profile_caregiver/domain/entity/profile_caregiver_data_entity.dart';

abstract class ProfileCaregiverRemoteDataSource {
  Future<ProfileCaregiverDataEntity> getProfileCaregiverData();
}

class ProfileCaregiverRemoteDataSourceImpl
    extends ProfileCaregiverRemoteDataSource {
  @override
  Future<ProfileCaregiverDataEntity> getProfileCaregiverData() async {
    final response = await DioHelper.getData(
      url: Endpoints.getCaregiverProfileData,
    );
    final data = ApiResponse<ProfileCaregiverModel>.fromJson(
      response.data,
      fromJsonT: (json) => ProfileCaregiverModel.fromJson(json),
    );
    return data.data!.toEntity();
  }
}
