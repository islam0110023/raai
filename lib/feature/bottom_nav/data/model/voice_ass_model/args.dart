class Args {
  String? kind;
  int? valueMgdl;

  Args({this.kind, this.valueMgdl});

  factory Args.fromJson(Map<String, dynamic> json) => Args(
    kind: json['kind'] as String?,
    valueMgdl: json['value_mgdl'] as int?,
  );

  Map<String, dynamic> toJson() => {'kind': kind, 'value_mgdl': valueMgdl};
}
