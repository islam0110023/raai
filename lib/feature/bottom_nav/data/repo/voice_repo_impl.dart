import 'package:dartz/dartz.dart';
import 'package:raai/core/failure/failure.dart';
import 'package:raai/feature/bottom_nav/data/data_source/voice_remote_data_source.dart';
import 'package:raai/feature/bottom_nav/domain/entity/voice_data_entity.dart';
import 'package:raai/feature/bottom_nav/domain/repo/voice_repo.dart';

class VoiceRepoImpl extends VoiceRepo {
  VoiceRepoImpl(this.remoteDataSource);

  final VoiceRemoteDataSource remoteDataSource;
  @override
  Future<Either<Failure, VoiceDataEntity>> analyzeVoice(String text) async {
    try {
      final data = await remoteDataSource.analyzeVoice(text);
      return Right(data);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
