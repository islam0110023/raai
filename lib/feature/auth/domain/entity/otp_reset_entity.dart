class OtpResetEntity {
  OtpResetEntity({
    required this.resetToken,
    required this.statusCode,
    required this.appCode,
    required this.statusMessage,
    required this.message,
  });

  final String resetToken;
  final int statusCode;
  final int appCode;
  final String statusMessage;
  final String message;
}
