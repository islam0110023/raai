import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/failure.dart';
import 'package:raai/feature/chat_bot/data/data_source/chat_bot_remote_data_source.dart';
import 'package:raai/feature/chat_bot/domain/entity/chat_bot_entity.dart';
import 'package:raai/feature/chat_bot/domain/param/history_param.dart';
import 'package:raai/feature/chat_bot/domain/repo/chat_bot_repo.dart';

class ChatBotRepoImpl extends ChatBotRepo {
  ChatBotRepoImpl(this.chatBotRemoteDataSource);

  final ChatBotRemoteDataSource chatBotRemoteDataSource;
  @override
  Future<Either<Failure, ChatBotEntity>> getMessages({
    required List<HistoryParam> historyParam,
    required String message,
    required String sessionId,
  }) async {
    try {
      final response = await chatBotRemoteDataSource.getMessages(
        historyParam: historyParam,
        message: message,
        sessionId: sessionId,
      );
      return Right(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return Left(Failure('السيرفر مش بيرد دلوقتي، حاول بعد شوية'));
      }

      if (e.response?.statusCode == 504) {
        return Left(Failure('السيرفر مش بيرد دلوقتي، حاول بعد شوية'));
      }

      return Left(Failure('حصل خطأ غير متوقع'));
    } catch (e) {
      return Left(Failure('حصل خطأ غير متوقع'));
    }
  }
}
