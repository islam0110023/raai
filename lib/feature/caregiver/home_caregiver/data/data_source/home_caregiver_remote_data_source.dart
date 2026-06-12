import 'package:raai/core/model/api_response.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/caregiver/home_caregiver/data/model/home_caregiver_data_model/home_caregiver_data_model.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_data_entity.dart';

abstract class HomeCaregiverRemoteDataSource {
  Future<HomeCaregiverDataEntity> getHomeCaregiverData();
}

class HomeCaregiverRemoteDataSourceImpl extends HomeCaregiverRemoteDataSource {
  @override
  Future<HomeCaregiverDataEntity> getHomeCaregiverData() async {
    final response = await DioHelper.getData(
      url: Endpoints.getCaregiverHomeData,
    );
    final data = ApiResponse<HomeCaregiverDataModel>.fromJson(
      response.data,
      fromJsonT: (json) => HomeCaregiverDataModel.fromJson(json),
    );
    return data.data!.toEntity();
  }
}
