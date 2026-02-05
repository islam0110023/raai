import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/chat_bot/domain/entity/chat_bot_entity.dart';
import 'package:raai/feature/chat_bot/domain/param/history_param.dart';

abstract class ChatBotRemoteDataSource {
  Future<ChatBotEntity> getMessages({
    required List<HistoryParam> historyParam,
    required String message,
    required String sessionId,
  });
}

class ChatBotRemoteDataSourceImpl extends ChatBotRemoteDataSource {
  @override
  Future<ChatBotEntity> getMessages({
    required List<HistoryParam> historyParam,
    required String message,
    required String sessionId,
  }) async {
    final response = await DioHelper.postData(
      url: Endpoints.chatBot,
      data: {
        'message': message,
        'sessionId': 'user_123',
        'history': historyParam.map((e) => e.toMap()).toList(),
      },
    );
    return ChatBotEntity(replay: response.data['reply']);
  }
}
