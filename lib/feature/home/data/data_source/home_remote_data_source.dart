import 'package:raai/core/model/api_response.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/home/data/model/home_data_model/home_data_model.dart';
import 'package:raai/feature/home/domain/entities/home_data_entity.dart';

abstract class HomeRemoteDataSource {
  Future<HomeDataEntity> getHomeData();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  @override
  Future<HomeDataEntity> getHomeData() async {
    final response = await DioHelper.getData(url: Endpoints.getHomeData);
    final data = ApiResponse<HomeDataModel>.fromJson(
      response.data,
      fromJsonT: (json) => HomeDataModel.fromJson(json),
    );
    return data.data!.toEntity();
  }
}
