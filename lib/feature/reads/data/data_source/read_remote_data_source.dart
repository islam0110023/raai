import 'package:dartz/dartz.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/reads/data/model/blood_read_model/blood_read_model.dart';
import 'package:raai/feature/reads/data/model/sugar_read_model/sugar_read_model.dart';
import 'package:raai/feature/reads/domain/entity/blood_read_entity.dart';
import 'package:raai/feature/reads/domain/entity/sugar_read_entity.dart';

abstract class ReadRemoteDataSource {
  Future<List<SugarReadEntity>> getSugarReads();
  Future<List<BloodReadEntity>> getBloodReads();
  Future<Unit> updateSugar({required String id, required String value});
  Future<Unit> updateBlood({
    required String id,
    required String systolic,
    required String diastolic,
  });
}

class ReadRemoteDataSourceImpl extends ReadRemoteDataSource {
  @override
  Future<List<SugarReadEntity>> getSugarReads() async {
    final response = await DioHelper.getData(url: Endpoints.getSugarReads);
    final data = ApiResponse<SugarReadModel>.fromJson(
      response.data,
      fromJsonT: (json) => SugarReadModel.fromJson(json),
    );
    return data.data!.toEntity();
  }

  @override
  Future<List<BloodReadEntity>> getBloodReads() async {
    final response = await DioHelper.getData(url: Endpoints.getBloodReads);
    final data = ApiResponse<BloodReadModel>.fromJson(
      response.data,
      fromJsonT: (json) => BloodReadModel.fromJson(json),
    );
    return data.data!.toEntity();
  }

  @override
  Future<Unit> updateSugar({required String id, required String value}) async {
    await DioHelper.putData(
      url: Endpoints.updateSugar + id,
      data: {'value': value},
    );
    return unit;
  }

  @override
  Future<Unit> updateBlood({
    required String id,
    required String systolic,
    required String diastolic,
  }) async {
    await DioHelper.putData(
      url: Endpoints.updateBlood + id,
      data: {'sys': systolic, 'dia': diastolic},
    );
    return unit;
  }
}
