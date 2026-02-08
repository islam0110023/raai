class Meta {
  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    readingsUsedForAi: json['readingsUsedForAi'] as int?,
    returnedReadings: json['returnedReadings'] as int?,
  );

  Meta({this.readingsUsedForAi, this.returnedReadings});
  int? readingsUsedForAi;
  int? returnedReadings;

  Map<String, dynamic> toJson() => {
    'readingsUsedForAi': readingsUsedForAi,
    'returnedReadings': returnedReadings,
  };
}
