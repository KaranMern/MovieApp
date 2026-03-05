import 'package:dio/dio.dart';
import 'package:sample/core/error/exception.dart';

/// Maps [DioException] from Dio into app-specific [AppException] types
/// for consistent error handling in the UI and repository layer.
class DioExceptionMapper {
  /// Returns the appropriate [AppException] based on [e.type] and, for
  /// [DioExceptionType.badResponse], the HTTP status code.
  static AppException map(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();

      case DioExceptionType.connectionError:
        return NetworkException();

      case DioExceptionType.cancel:
        return RequestCancelledException();

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;

        switch (statusCode) {
          case 401:
            return UnauthorizedException();
          case 403:
            return ForbiddenException();
          case 404:
            return NotFoundException();
          case 500:
            return ServerException();
          default:
            return ServerException(message: 'Server error: $statusCode');
        }

      case DioExceptionType.unknown:
      default:
        return NetworkException(
          message: e.message ?? 'Unexpected error occurred',
        );
    }
  }
}
