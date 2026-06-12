import 'package:dartz/dartz.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';

abstract class ConnectElderCaregiverRemoteDataSource {
  Future<Unit> connectCaregiverWithElder(String code);
}

class ConnectElderCaregiverRemoteDataSourceImpl
    extends ConnectElderCaregiverRemoteDataSource {
  @override
  Future<Unit> connectCaregiverWithElder(String code) async {
    await DioHelper.postData(
      url: Endpoints.connectCaregiverWithElder,
      data: {'code': code},
    );
    return unit;
  }
}
