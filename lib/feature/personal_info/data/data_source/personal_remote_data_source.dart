import 'package:dartz/dartz.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';

abstract class PersonalRemoteDataSource {
  Future<Unit> setPersonalInfo({
    required String gender,
    required String birthDate,
    required String firstName,
    required String lastName,
  });
}

class PersonalRemoteDataSourceImpl extends PersonalRemoteDataSource {
  @override
  Future<Unit> setPersonalInfo({
    required String gender,
    required String birthDate,
    required String firstName,
    required String lastName,
  }) async {
    await DioHelper.postData(
      url: Endpoints.personalData,
      data: {
        'gender': gender,
        'birthDate': birthDate,
        'firstName': firstName,
        'lastName': lastName,
      },
    );
    return unit;
  }
}
