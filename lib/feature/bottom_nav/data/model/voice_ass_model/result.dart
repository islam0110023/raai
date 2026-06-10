import 'args.dart';

class Result {
  bool? ok;
  String? function;
  Args? args;

  Result({this.ok, this.function, this.args});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    ok: json['ok'] as bool?,
    function: json['function'] as String?,
    args: json['args'] == null
        ? null
        : Args.fromJson(json['args'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'ok': ok,
    'function': function,
    'args': args?.toJson(),
  };
}
