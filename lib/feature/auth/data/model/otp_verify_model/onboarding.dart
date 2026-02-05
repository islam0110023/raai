class Onboarding {
  factory Onboarding.fromJson(Map<String, dynamic> json) => Onboarding(
    nextStep: json['nextStep'] as String?,
    isCompleted: json['isCompleted'] as bool?,
  );

  Onboarding({this.nextStep, this.isCompleted});
  String? nextStep;
  bool? isCompleted;

  Map<String, dynamic> toJson() => {
    'nextStep': nextStep,
    'isCompleted': isCompleted,
  };
}
