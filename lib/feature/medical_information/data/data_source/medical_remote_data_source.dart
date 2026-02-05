import 'package:dartz/dartz.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';

abstract class MedicalRemoteDataSource {
  Future<Unit> setMedical({required Map<String, dynamic> data});
}

class MedicalRemoteDataSourceImpl extends MedicalRemoteDataSource {
  @override
  Future<Unit> setMedical({required Map<String, dynamic> data}) async {
    await DioHelper.postData(url: Endpoints.setMedical, data: data);
    return unit;
  }
}
