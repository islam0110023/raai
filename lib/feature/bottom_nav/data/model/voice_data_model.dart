import 'package:raai/feature/bottom_nav/data/model/voice_data_args_model.dart';
import 'package:raai/feature/bottom_nav/domain/entity/voice_data_entity.dart';

class VoiceDataModel {
  factory VoiceDataModel.fromJson(Map<String, dynamic> json) => VoiceDataModel(
    function: json['function'] as String?,
    message: json['message'] as String?,
    args: json['args'] == null
        ? null
        : VoiceDataArgsModel.fromJson(json['args'] as Map<String, dynamic>),
  );
  VoiceDataModel({this.function, this.message, this.args});
  String? function;
  String? message;
  VoiceDataArgsModel? args;
  Map<String, dynamic> toJson() => {
    'function': function,
    'message': message,
    'args': args?.toJson(),
  };
  VoiceDataEntity toEntity() {
    return VoiceDataEntity(
      function: function ?? '',
      message: message,
      dia: args?.dia,
      sys: args?.sys,
      valueMgdl: args?.valueMgdl,
      error: args?.error,
      kind: args?.kind,
      messageArgs: args?.message,
    );
  }
}
