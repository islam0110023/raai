class BloodPressure {

  factory BloodPressure.fromJson(Map<String, dynamic> json) => BloodPressure(
    systolic: json['systolic'] as int?,
    diastolic: json['diastolic'] as int?,
    status: json['status'] as String?,
    recordedAt: json['recordedAt'] == null
        ? null
        : DateTime.parse(json['recordedAt'] as String),
  );

  BloodPressure({this.systolic, this.diastolic, this.status, this.recordedAt});
  int? systolic;
  int? diastolic;
  String? status;
  DateTime? recordedAt;

  Map<String, dynamic> toJson() => {
    'systolic': systolic,
    'diastolic': diastolic,
    'status': status,
    'recordedAt': recordedAt?.toIso8601String(),
  };
}
