import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart';

enum VoiceState { idle, listening, done }

class VoiceCubit extends Cubit<VoiceState> {
  VoiceCubit() : super(VoiceState.idle) {
    init();
  }

  final SpeechToText speech = SpeechToText();

  final _textController = StreamController<String>.broadcast();
  Stream<String> get textStream => _textController.stream;
  String lastText = '';

  Future<void> init() async {
    await speech.initialize(
      onStatus: (status) => print("Status: $status"),
      onError: (error) => print("Error: $error"),
    );
  }

  void startListening() async {
    await speech.stop();

    lastText = '';
    _textController.add('');

    emit(VoiceState.listening);

    await Future.delayed(const Duration(milliseconds: 200));

    speech.listen(
      localeId: 'ar_EG',
      pauseFor: const Duration(seconds: 5),
      listenFor: const Duration(seconds: 10),
      onResult: (result) {
        final text = result.recognizedWords;

        lastText = text;
        _textController.add(text);

        if (result.finalResult) {
          emit(VoiceState.done);
        }
      },
    );
  }

  void stopListening() {
    speech.stop();
    emit(VoiceState.idle);
  }

  void resetText() {
    lastText = '';
    _textController.add('');
    emit(VoiceState.listening);
  }

  @override
  Future<void> close() {
    _textController.close();
    return super.close();
  }
}
