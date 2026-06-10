import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/bottom_nav/data/model/voice_data_model.dart';
import 'package:raai/feature/bottom_nav/domain/entity/voice_data_entity.dart';

abstract class VoiceRemoteDataSource {
  Future<VoiceDataEntity> analyzeVoice(String text);
}

class VoiceRemoteDataSourceImpl extends VoiceRemoteDataSource {
  @override
  Future<VoiceDataEntity> analyzeVoice(String text) async {
    final response = await DioHelper.postData(
      url: Endpoints.analyzeVoice,
      data: {'text': text},
    );
    return VoiceDataModel.fromJson(response.data).toEntity();
  }
}
