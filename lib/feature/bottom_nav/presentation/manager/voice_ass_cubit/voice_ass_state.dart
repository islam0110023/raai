part of 'voice_ass_cubit.dart';

@immutable
sealed class VoiceAssState {}

final class VoiceAssInitial extends VoiceAssState {}

final class VoiceAssLoading extends VoiceAssState {}

final class VoiceAssSuccess extends VoiceAssState {
  final VoiceAssModel text;
  VoiceAssSuccess({required this.text});
}

final class VoiceAssFailure extends VoiceAssState {}
