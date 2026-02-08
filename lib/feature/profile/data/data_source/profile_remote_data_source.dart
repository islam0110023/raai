import 'package:raai/core/model/api_response.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/profile/data/model/profile_user_model/profile_user_model.dart';
import 'package:raai/feature/profile/domain/entity/profile_user_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileUserEntity> getUserProfile();
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  @override
  Future<ProfileUserEntity> getUserProfile() async {
    final response = await DioHelper.getData(url: Endpoints.getUserProfile);
    final data = ApiResponse<ProfileUserModel>.fromJson(
      response.data,
      fromJsonT: (json) => ProfileUserModel.fromJson(json),
    );
    return data.data!.toEntity();
  }
}
