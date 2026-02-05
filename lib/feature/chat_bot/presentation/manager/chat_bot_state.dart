part of 'chat_bot_cubit.dart';

@immutable
sealed class ChatBotState {}

final class ChatBotInitial extends ChatBotState {}

final class ChatBotSuccess extends ChatBotState {
  ChatBotSuccess(this.chatBotEntity);

  final ChatBotEntity chatBotEntity;
}

final class ChatBotLoading extends ChatBotState {}

final class ChatBotFailure extends ChatBotState {
  ChatBotFailure(this.message);

  final String message;
}

final class ChatBotMessageAdd extends ChatBotState {}
