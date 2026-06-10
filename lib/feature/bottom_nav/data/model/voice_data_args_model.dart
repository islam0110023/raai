class VoiceDataArgsModel {
  factory VoiceDataArgsModel.fromJson(Map<String, dynamic> json) =>
      VoiceDataArgsModel(
        kind: json['kind'] as String?,
        sys: json['sys'] as int?,
        dia: json['dia'] as int?,
        valueMgdl: json['value_mgdl'] as int?,
        error: json['error'] as String?,
        message: json['message'] as String?,
      );
  VoiceDataArgsModel({
    this.kind,
    this.sys,
    this.dia,
    this.valueMgdl,
    this.error,
    this.message,
  });
  String? kind;
  int? sys;
  int? dia;
  int? valueMgdl;
  String? error;
  String? message;
  Map<String, dynamic> toJson() => {
    'kind': kind,
    'sys': sys,
    'dia': dia,
    'value_mgdl': valueMgdl,
    'error': error,
    'message': message,
  };
}
