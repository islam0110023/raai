class ResetData {
  ResetData({required this.resetRequestId});

  factory ResetData.fromJson(Map<String, dynamic> json) {
    return ResetData(resetRequestId: json['resetRequestId']);
  }
  final int resetRequestId;
}
