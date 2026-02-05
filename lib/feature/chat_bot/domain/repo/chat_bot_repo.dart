import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/failure.dart';
import 'package:raai/feature/chat_bot/domain/entity/chat_bot_entity.dart';
import 'package:raai/feature/chat_bot/domain/param/history_param.dart';

abstract class ChatBotRepo {
  Future<Either<Failure, ChatBotEntity>> getMessages({
    required List<HistoryParam> historyParam,
    required String message,
    required String sessionId,
  });
}
