class Schedule {
  Schedule({
    this.id,
    this.medicationId,
    this.dosesPerDay,
    this.repeatType,
    this.startTime,
    this.withFood,
    this.foodTiming,
    this.pillsPerDose,
    this.totalPills,
    this.createdAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    id: json['id'] as int?,
    medicationId: json['medicationId'] as int?,
    dosesPerDay: json['dosesPerDay'] as int?,
    repeatType: json['repeatType'] as String?,
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    withFood: json['withFood'] as bool?,
    foodTiming: json['foodTiming'] as dynamic,
    pillsPerDose: json['pillsPerDose'] as int?,
    totalPills: json['totalPills'] as int?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
  int? id;
  int? medicationId;
  int? dosesPerDay;
  String? repeatType;
  DateTime? startTime;
  bool? withFood;
  String? foodTiming;
  int? pillsPerDose;
  int? totalPills;
  DateTime? createdAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'medicationId': medicationId,
    'dosesPerDay': dosesPerDay,
    'repeatType': repeatType,
    'startTime': startTime?.toIso8601String(),
    'withFood': withFood,
    'foodTiming': foodTiming,
    'pillsPerDose': pillsPerDose,
    'totalPills': totalPills,
    'createdAt': createdAt?.toIso8601String(),
  };
}
