class Status {
  String? code;
  String? label;
  bool? canSendReminder;

  Status({this.code, this.label, this.canSendReminder});

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json['code'] as String?,
    label: json['label'] as String?,
    canSendReminder: json['canSendReminder'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'code': code,
    'label': label,
    'canSendReminder': canSendReminder,
  };
}
