import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raai/feature/bottom_nav/domain/entity/voice_data_entity.dart';
import 'package:raai/feature/bottom_nav/domain/use_case/analyze_voice_use_case.dart';
import 'package:speech_to_text/speech_to_text.dart';

abstract class VoiceAssistantState {}

class VoiceAssistantInitial extends VoiceAssistantState {}

class VoiceAssistantInitialized extends VoiceAssistantState {}

class VoiceAssistantInitializing extends VoiceAssistantState {}

class VoiceAssistantListening extends VoiceAssistantState {
  VoiceAssistantListening({
    required this.amplitude,
    required this.recognizedText,
  });
  final double amplitude;
  final String recognizedText;
}

class VoiceAssistantProcessing extends VoiceAssistantState {}

class VoiceAssistantSuccess extends VoiceAssistantState {
  VoiceAssistantSuccess(this.responseData);
  final VoiceDataEntity responseData;
}

class VoiceAssistantError extends VoiceAssistantState {
  VoiceAssistantError(this.message, {this.isPermissionError = false});
  final String message;
  final bool isPermissionError;
}

// --- Cubit ---
class VoiceAssistantCubit extends Cubit<VoiceAssistantState> {
  VoiceAssistantCubit(this.analyzeVoiceUseCase)
    : super(VoiceAssistantInitial());

  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;
  bool _isAnalyzing = false;
  double _minMicLevel = 100.0;
  double _maxMicLevel = -100.0;
  DateTime _lastEmitTime = DateTime.now();
  final AnalyzeVoiceUseCase analyzeVoiceUseCase;
  Future<void> initSpeech() async {
    if (_isInitialized) return;

    emit(VoiceAssistantInitializing());
    try {
      _isInitialized = await _speechToText.initialize(
        onError: (val) => emit(VoiceAssistantError(val.errorMsg)),
        onStatus: (status) {
          if (status == 'notListening' &&
              state is VoiceAssistantListening &&
              !_isAnalyzing) {
            emit(VoiceAssistantInitialized());
          }
        },
      );

      if (_isInitialized) {
        emit(VoiceAssistantInitialized());
      } else {
        emit(
          VoiceAssistantError(
            'تم رفض صلاحية استخدام المايكروفون',
            isPermissionError: true,
          ),
        );
      }
    } catch (e) {
      emit(VoiceAssistantError('خطأ أثناء تهيئة المايك: $e'));
    }
  }

  Future<void> startListening() async {
    if (!_isInitialized) {
      await initSpeech();
      if (!_isInitialized) return;
    }
    _isAnalyzing = false;
    try {
      emit(
        VoiceAssistantListening(
          amplitude: 0.0,
          recognizedText: 'جاري الاستماع...',
        ),
      );
      await _speechToText.listen(
        listenOptions: SpeechListenOptions(localeId: 'ar_EG'),
        // pauseFor: const Duration(seconds: 4),
        // listenFor: const Duration(seconds: 20),
        onResult: (result) {
          if (state is VoiceAssistantListening) {
            emit(
              VoiceAssistantListening(
                amplitude: (state as VoiceAssistantListening).amplitude,
                recognizedText: result.recognizedWords.isEmpty
                    ? 'جاري الاستماع...'
                    : result.recognizedWords,
              ),
            );
          }
        },
        onSoundLevelChange: (level) {
          final now = DateTime.now();

          if (now.difference(_lastEmitTime).inMilliseconds < 30) {
            return;
          }

          if (level < _minMicLevel) _minMicLevel = level;
          if (level > _maxMicLevel) _maxMicLevel = level;

          final double range = _maxMicLevel - _minMicLevel;
          double normalized = 0.0;

          if (range > 1.0) {
            normalized = (level - _minMicLevel) / range;
          }

          if (level <= _minMicLevel + (range * 0.20)) {
            normalized = 0.0;
          }

          if (state is VoiceAssistantListening) {
            final currentState = state as VoiceAssistantListening;
            final double previousAmp = currentState.amplitude;

            final double smoothedAmp =
                previousAmp + (normalized - previousAmp) * 0.5;
            _lastEmitTime = now;

            emit(
              VoiceAssistantListening(
                amplitude: smoothedAmp.clamp(0.0, 1.0),
                recognizedText: currentState.recognizedText,
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(VoiceAssistantError('فشل بدء الاستماع: $e'));
      // emit(VoiceAssistantInitialized());
    }
  }

  Future<void> stopListeningAndAnalyze() async {
    if (state is! VoiceAssistantListening) return;

    final currentListeningState = state as VoiceAssistantListening;
    final textToSend = currentListeningState.recognizedText;

    _isAnalyzing = true;
    await _speechToText.stop();

    if (textToSend == 'جاري الاستماع...' || textToSend.trim().isEmpty) {
      _isAnalyzing = false;
      emit(VoiceAssistantInitialized());
      return;
    }

    emit(VoiceAssistantProcessing());
    final result = await analyzeVoiceUseCase(textToSend);
    result.fold(
      (failure) {
        _isAnalyzing = false;
        emit(VoiceAssistantError(failure.message));
      },
      (data) {
        _isAnalyzing = false;
        emit(VoiceAssistantSuccess(data));
      },
    );
  }

  Future<void> stopListeningOnly() async {
    _isAnalyzing = false;
    await _speechToText.stop();
    emit(VoiceAssistantInitialized());
  }
}
