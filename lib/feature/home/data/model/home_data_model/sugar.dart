class Sugar {

  Sugar({this.value, this.status, this.recordedAt});

  factory Sugar.fromJson(Map<String, dynamic> json) => Sugar(
    value: json['value'] as int?,
    status: json['status'] as String?,
    recordedAt: json['recordedAt'] == null
        ? null
        : DateTime.parse(json['recordedAt'] as String),
  );
  int? value;
  String? status;
  DateTime? recordedAt;

  Map<String, dynamic> toJson() => {
    'value': value,
    'status': status,
    'recordedAt': recordedAt?.toIso8601String(),
  };
}
