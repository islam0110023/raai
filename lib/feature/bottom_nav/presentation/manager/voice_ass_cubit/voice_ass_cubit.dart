import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/bottom_nav/data/model/voice_ass_model/voice_ass_model.dart';

part 'voice_ass_state.dart';

class VoiceAssCubit extends Cubit<VoiceAssState> {
  VoiceAssCubit() : super(VoiceAssInitial());
  void getPredictVoice(String text) async {
    try {
      emit(VoiceAssLoading());

      final response = await DioHelper.postData(
        url: 'https://ra3y.ddns.net/ai/voice-assistant/predict-intent',
        data: {'text': text},
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        emit(VoiceAssSuccess(text: VoiceAssModel.fromJson(response.data)));
      } else {
        emit(VoiceAssFailure());
      }
    } catch (e) {
      log(e.toString());
      emit(VoiceAssFailure());
    }
  }
}
