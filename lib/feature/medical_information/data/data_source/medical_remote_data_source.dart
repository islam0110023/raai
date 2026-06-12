import 'package:dio/dio.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';

abstract class MedicalRemoteDataSource {
  Future<int> setMedical({required Map<String, dynamic> data, int? elderId});
}

class MedicalRemoteDataSourceImpl extends MedicalRemoteDataSource {
  @override
  Future<int> setMedical({
    required Map<String, dynamic> data,
    int? elderId,
  }) async {
    final Response result;
    if (elderId != null) {
      result = await DioHelper.postData(
        url: Endpoints.setMedicalByCaregiver(elderId),
        data: data,
      );
    } else {
      result = await DioHelper.postData(url: Endpoints.setMedical, data: data);
    }
    final appCode = ApiResponse.fromJson(result.data);
    return appCode.appCode!;
  }
}
