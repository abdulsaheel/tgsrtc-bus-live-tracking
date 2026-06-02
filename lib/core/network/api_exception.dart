import 'package:dio/dio.dart';

/// Normalized, user-presentable network error. Keeps the UI's error states
/// honest (UX rule: never a silent failure).
class ApiException implements Exception {
  ApiException(this.message, {this.statusCode, this.isOffline = false});

  final String message;
  final int? statusCode;
  final bool isOffline;

  factory ApiException.from(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('The request timed out. Please try again.');
      case DioExceptionType.connectionError:
        return ApiException(
          'No internet connection. Showing last known data where available.',
          isOffline: true,
        );
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        return ApiException(
          'Server error ($code). Please try again shortly.',
          statusCode: code,
        );
      default:
        return ApiException('Something went wrong. Please try again.');
    }
  }

  @override
  String toString() => message;
}
