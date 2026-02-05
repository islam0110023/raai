class LoginEntity {
  LoginEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.statusCode,
    required this.appCode,
    required this.statusMessage,
    required this.message,
  });

  final String accessToken;
  final String refreshToken;
  final int statusCode;
  final int appCode;
  final String statusMessage;
  final String message;
}
