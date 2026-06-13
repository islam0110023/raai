class Summary {
  int? taken;
  int? missed;
  int? upcoming;
  int? snoozed;

  Summary({this.taken, this.missed, this.upcoming, this.snoozed});

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    taken: json['taken'] as int?,
    missed: json['missed'] as int?,
    upcoming: json['upcoming'] as int?,
    snoozed: json['snoozed'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'taken': taken,
    'missed': missed,
    'upcoming': upcoming,
    'snoozed': snoozed,
  };
}
