class Schedule {
  Schedule({
    this.dosesPerDay,
    this.pillsPerDose,
    this.totalPills,
    this.remainingPills,
    this.repeatType,
    this.withFood,
    this.foodTiming,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    dosesPerDay: json['dosesPerDay'] as int?,
    pillsPerDose: json['pillsPerDose'] as int?,
    totalPills: json['totalPills'] as int?,
    remainingPills: json['remainingPills'] as dynamic,
    repeatType: json['repeatType'] as String?,
    withFood: json['withFood'] as bool?,
    foodTiming: json['foodTiming'] as String?,
  );
  int? dosesPerDay;
  int? pillsPerDose;
  int? totalPills;
  int? remainingPills;
  String? repeatType;
  bool? withFood;
  String? foodTiming;

  Map<String, dynamic> toJson() => {
    'dosesPerDay': dosesPerDay,
    'pillsPerDose': pillsPerDose,
    'totalPills': totalPills,
    'remainingPills': remainingPills,
    'repeatType': repeatType,
    'withFood': withFood,
    'foodTiming': foodTiming,
  };
}
