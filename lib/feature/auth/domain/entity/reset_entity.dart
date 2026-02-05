class ResetEntity {
  ResetEntity({
    required this.resetRequestId,
    required this.statusCode,
    required this.appCode,
    required this.statusMessage,
    required this.message,
  });

  final int? resetRequestId;
  final int statusCode;
  final int appCode;
  final String statusMessage;
  final String message;
}
