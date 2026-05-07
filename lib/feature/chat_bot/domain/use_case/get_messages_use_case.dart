import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/failure.dart';
import 'package:raai/feature/chat_bot/domain/entity/chat_bot_entity.dart';
import 'package:raai/feature/chat_bot/domain/param/history_param.dart';
import 'package:raai/feature/chat_bot/domain/repo/chat_bot_repo.dart';

class GetMessagesUseCase {
  const GetMessagesUseCase(this.chatBotRepo);
  final ChatBotRepo chatBotRepo;
  Future<Either<Failure, ChatBotEntity>> call({
    required List<HistoryParam> historyParam,
    required String message,
    required String sessionId,
    required String userName,
    required String userGender,
  }) async {
    return await chatBotRepo.getMessages(
      historyParam: historyParam,
      message: message,
      sessionId: sessionId,
      userName: userName,
      userGender: userGender,
    );
  }
}
