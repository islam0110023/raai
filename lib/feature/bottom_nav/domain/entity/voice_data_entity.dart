class VoiceDataEntity {
  VoiceDataEntity({
    required this.function,
    required this.message,
    required this.sys,
    required this.dia,
    required this.valueMgdl,
    required this.error,
    required this.kind,
    required this.messageArgs,
  });

  final String function;
  final String? message;
  final int? sys;
  final int? dia;
  final int? valueMgdl;
  final String? error;
  final String? kind;
  final String? messageArgs;
}
