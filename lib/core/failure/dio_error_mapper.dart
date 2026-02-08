import 'dart:io';
import 'package:dio/dio.dart';
import 'package:raai/core/failure/api_failure.dart';

class DioErrorMapper {
  static ApiFailure map(DioException e) {
    // No internet / DNS / host lookup
    if (e.type == DioExceptionType.connectionError) {
      return ServerFailure(998);
    }

    // Timeouts
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ServerFailure(997);
    }

    // // Bad response from server
    // if (e.type == DioExceptionType.badResponse) {
    //   final msg = e.response?.data?['message']?.toString() ?? 'Server error';
    //   return ServerException(msg);
    // }

    // Fallback
    if (e.error is SocketException) {
      return ServerFailure(998);
    }

    return ServerFailure(999);
  }
}
