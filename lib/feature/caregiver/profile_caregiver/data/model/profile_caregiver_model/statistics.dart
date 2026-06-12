class Statistics {
  Statistics({
    this.eldersCount,
    this.primaryEldersCount,
    this.viewerEldersCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    eldersCount: json['eldersCount'] as int?,
    primaryEldersCount: json['primaryEldersCount'] as int?,
    viewerEldersCount: json['viewerEldersCount'] as int?,
  );
  int? eldersCount;
  int? primaryEldersCount;
  int? viewerEldersCount;

  Map<String, dynamic> toJson() => {
    'eldersCount': eldersCount,
    'primaryEldersCount': primaryEldersCount,
    'viewerEldersCount': viewerEldersCount,
  };
}
