import 'package:dartz/dartz.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';

abstract class AddReadRemoteDataSource {
  Future<Unit> addSugar({required String sugar});
  Future<Unit> addBlood({required String systolic, required String diastolic});
}

class AddReadRemoteDataSourceImpl extends AddReadRemoteDataSource {
  @override
  Future<Unit> addSugar({required String sugar}) async {
    await DioHelper.postData(url: Endpoints.addSugar, data: {'value': sugar});
    return unit;
  }

  @override
  Future<Unit> addBlood({
    required String systolic,
    required String diastolic,
  }) async {
    await DioHelper.postData(
      url: Endpoints.addBlood,
      data: {'sys': systolic, 'dia': diastolic},
    );
    return unit;
  }
}
