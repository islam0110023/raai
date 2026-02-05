class ApiResponse<T> {
  ApiResponse({
    required this.statusCode,
    this.appCode,
    required this.statusMessage,
    this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic json)? fromJsonT,
  }) {
    return ApiResponse<T>(
      statusCode: json['statusCode'],
      appCode: json['appCode'],
      statusMessage: json['statusMessage'] ?? '',
      message: json['message'],
      data: fromJsonT != null && json['data'] != null
          ? fromJsonT(json['data'])
          : null,
    );
  }
  final int statusCode;
  final int? appCode;
  final String statusMessage;
  final String? message;
  final T? data;
}
