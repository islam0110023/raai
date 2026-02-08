class Meta {
  Meta({this.readingsUsedForAi, this.window});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    readingsUsedForAi: json['readingsUsedForAi'] as int?,
    window: json['window'] as String?,
  );
  int? readingsUsedForAi;
  String? window;

  Map<String, dynamic> toJson() => {
    'readingsUsedForAi': readingsUsedForAi,
    'window': window,
  };
}
