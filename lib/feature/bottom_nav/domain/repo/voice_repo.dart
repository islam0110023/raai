import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/failure.dart';
import 'package:raai/feature/bottom_nav/domain/entity/voice_data_entity.dart';

abstract class VoiceRepo {
  Future<Either<Failure, VoiceDataEntity>> analyzeVoice(String text);
}
