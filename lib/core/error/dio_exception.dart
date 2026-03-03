import 'package:dio/dio.dart';
import 'exception.dart';

class DioExceptionMapper {
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
          case 400:
            return BadRequestException(message: e.response?.data['message']);
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
