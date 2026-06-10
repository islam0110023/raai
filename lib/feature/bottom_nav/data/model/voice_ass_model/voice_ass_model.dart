import 'result.dart';

class VoiceAssModel {
  bool? ok;
  String? intent;
  double? confidence;
  dynamic message;
  Result? result;
  dynamic routing;
  dynamic topMatches;

  VoiceAssModel({
    this.ok,
    this.intent,
    this.confidence,
    this.message,
    this.result,
    this.routing,
    this.topMatches,
  });

  factory VoiceAssModel.fromJson(Map<String, dynamic> json) => VoiceAssModel(
    ok: json['ok'] as bool?,
    intent: json['intent'] as String?,
    confidence: (json['confidence'] as num?)?.toDouble(),
    message: json['message'] as dynamic,
    result: json['result'] == null
        ? null
        : Result.fromJson(json['result'] as Map<String, dynamic>),
    routing: json['routing'] as dynamic,
    topMatches: json['top_matches'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'ok': ok,
    'intent': intent,
    'confidence': confidence,
    'message': message,
    'result': result?.toJson(),
    'routing': routing,
    'top_matches': topMatches,
  };
}
