class Overview {
  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    good: json['good'] as int?,
    warning: json['warning'] as int?,
    critical: json['critical'] as int?,
  );

  Overview({this.good, this.warning, this.critical});
  int? good;
  int? warning;
  int? critical;

  Map<String, dynamic> toJson() => {
    'good': good,
    'warning': warning,
    'critical': critical,
  };
}
