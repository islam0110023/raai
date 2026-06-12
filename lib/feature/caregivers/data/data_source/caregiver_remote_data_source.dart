import 'package:raai/core/model/api_response.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/caregivers/data/model/caregiver_list_model/caregiver_list_model.dart';
import 'package:raai/feature/caregivers/domain/entity/caregiver_list_entity.dart';

abstract class CaregiverRemoteDataSource {
  Future<List<CaregiverListEntity>> getCaregiverList();
}

class CaregiverRemoteDataSourceImpl extends CaregiverRemoteDataSource {
  @override
  Future<List<CaregiverListEntity>> getCaregiverList() async {
    final response = await DioHelper.getData(url: Endpoints.getCaregiverList);
    final data = ApiResponse<List<CaregiverListModel>>.fromJson(
      response.data,
      fromJsonT: (json) => List<CaregiverListModel>.from(
        json.map((e) => CaregiverListModel.fromJson(e)).toList(),
      ),
    );
    return data.data!.map((e) => e.toEntity()).toList();
  }
}
