class TabletModelEntity {
  factory TabletModelEntity.fromJson(Map<String, dynamic> json) {
    return TabletModelEntity(
      pillCount: json['pill_count'],
      emptyCount: json['empty_count'],
      totalSlots: json['total_slots'],
    );
  }
  TabletModelEntity({this.pillCount, this.emptyCount, this.totalSlots});
  int? pillCount;
  int? emptyCount;
  int? totalSlots;
}
