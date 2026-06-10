import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/failure.dart';
import 'package:raai/feature/bottom_nav/domain/entity/voice_data_entity.dart';
import 'package:raai/feature/bottom_nav/domain/repo/voice_repo.dart';

class AnalyzeVoiceUseCase {
  AnalyzeVoiceUseCase(this.voiceRepo);

  final VoiceRepo voiceRepo;

  Future<Either<Failure, VoiceDataEntity>> call(String text) async {
    return await voiceRepo.analyzeVoice(text);
  }
}
