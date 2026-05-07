import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/feature/chat_bot/data/model/show_message_model.dart';
import 'package:raai/feature/chat_bot/domain/entity/chat_bot_entity.dart';
import 'package:raai/feature/chat_bot/domain/param/history_param.dart';
import 'package:raai/feature/chat_bot/domain/use_case/get_messages_use_case.dart';

part 'chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit(this.getMessagesUseCase) : super(ChatBotInitial());
  final GetMessagesUseCase getMessagesUseCase;
  List<HistoryParam> histories = [];
  TextEditingController textEditingController = TextEditingController();
  String? _lastUserMessage;

  List<ShowMessageModel> messages = [
    ShowMessageModel(
      message:
          '''مرحبًا، أنا راعي  مساعدك الصحي الذكي، موجود لمساعدتك في متابعة حالتك الصحية والإجابة عن استفساراتك. كيف يمكنني مساعدتك الآن؟''',
      role: 'model',
    ),
  ];

  Future<void> getMessages({
    required String sessionId,
    required String userName,
    required String userGender,
  }) async {
    final result = await getMessagesUseCase.call(
      historyParam: histories,
      message: _lastUserMessage ?? textEditingController.text,
      sessionId: sessionId,
      userName: userName,
      userGender: userGender,
    );
    result.fold(
      (l) {
        removeLoadingIfExist();
        removeLastErrorIfExist();
        messages.add(
          ShowMessageModel(message: l.message, role: 'error', isError: true),
        );
        emit(ChatBotFailure(l.message));
      },
      (r) {
        histories.add(HistoryParam(text: r.replay, role: 'model'));
        removeLoadingIfExist();
        messages.add(ShowMessageModel(message: r.replay, role: 'model'));
        textEditingController.clear();
        _lastUserMessage = null;
        emit(ChatBotSuccess(r));
      },
    );
  }

  DateTime? lastRetryTime;

  void retryLastMessage({
    required String sessionId,
    required String userName,
    required String userGender,
  }) {
    if (_lastUserMessage == null) return;

    if (lastRetryTime != null &&
        DateTime.now().difference(lastRetryTime!).inSeconds < 10) {
      return;
    }
    lastRetryTime = DateTime.now();

    removeLastErrorIfExist();

    removeLoadingIfExist();
    messages.add(ShowMessageModel(message: '', role: 'model', isLoading: true));

    emit(ChatBotMessageAdd());

    getMessages(
      sessionId: sessionId,
      userName: userName,
      userGender: userGender,
    );
  }

  void removeLoadingIfExist() {
    if (messages.isNotEmpty && messages.last.isLoading) {
      messages.removeLast();
    }
  }

  void removeLastErrorIfExist() {
    if (messages.isNotEmpty && messages.last.isError) {
      messages.removeLast();
    }
  }

  void addMessage(String message) {
    _lastUserMessage = message;
    histories.add(HistoryParam(text: message, role: 'user'));
    messages.add(ShowMessageModel(message: message, role: 'user'));
    messages.add(ShowMessageModel(message: '', role: 'bot', isLoading: true));
    emit(ChatBotMessageAdd());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    textEditingController.dispose();
    return super.close();
  }
}
