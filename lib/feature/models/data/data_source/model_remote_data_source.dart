import 'package:raai/core/model/api_response.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/models/data/model/sugar_daily_model/sugar_daily_model.dart';
import 'package:raai/feature/models/data/model/sugar_monthly_model/sugar_monthly_model.dart';
import 'package:raai/feature/models/domain/entity/sugar_daily_entity.dart';
import 'package:raai/feature/models/domain/entity/sugar_monthly_entity.dart';

abstract class ModelRemoteDataSource {
  Future<SugarMonthlyEntity> getSugarMonthly();
  Future<SugarDailyEntity> getSugarDaily();
}

class ModelRemoteDataSourceImpl extends ModelRemoteDataSource {
  @override
  Future<SugarMonthlyEntity> getSugarMonthly() async {
    final response = await DioHelper.getData(url: Endpoints.getSugarMonthly);
    final data = ApiResponse<SugarMonthlyModel>.fromJson(
      response.data,
      fromJsonT: (json) => SugarMonthlyModel.fromJson(json),
    );
    return data.data!.toEntity();
  }

  @override
  Future<SugarDailyEntity> getSugarDaily() async {
    final response = await DioHelper.getData(url: Endpoints.getSugarDaily);
    final data = ApiResponse<SugarDailyModel>.fromJson(
      response.data,
      fromJsonT: (json) => SugarDailyModel.fromJson(json),
    );
    return data.data!.toEntity();
  }
}
