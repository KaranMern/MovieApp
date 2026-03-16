/// Base exception type for the app. All domain exceptions extend this
/// and expose [message] and optional [prefix] for consistent formatting.
abstract class AppException implements Exception {
  AppException({required this.message, this.prefix});
  final String message;
  final String? prefix;

  @override
  String toString() {
    return '$prefix$message';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Network-related exceptions
// ─────────────────────────────────────────────────────────────────────────────

class NetworkException extends AppException {
  NetworkException({super.message = 'No internet connection'})
      : super(prefix: 'Network Error: ');
}

class TimeoutException extends AppException {
  TimeoutException({super.message = 'Connection timeout'})
      : super(prefix: 'Timeout Error: ');
}

// ─────────────────────────────────────────────────────────────────────────────
// Server / HTTP exceptions
// ─────────────────────────────────────────────────────────────────────────────

class ServerException extends AppException {
  ServerException({super.message = 'Internal server error'})
      : super(prefix: 'Server Error: ');
}

class BadRequestException extends AppException {
  BadRequestException({String? message})
      : super(message: message ?? 'Bad request', prefix: 'Invalid Request: ');
}

class UnauthorizedException extends AppException {
  UnauthorizedException({String? message})
      : super(message: message ?? 'Unauthorized', prefix: 'Unauthorized: ');
}

class ForbiddenException extends AppException {
  ForbiddenException({String? message})
      : super(message: message ?? 'Forbidden', prefix: 'Forbidden: ');
}

class NotFoundException extends AppException {
  NotFoundException({String? message})
      : super(message: message ?? 'Not found', prefix: 'Not Found: ');
}

class RequestCancelledException extends AppException {
  RequestCancelledException({super.message = 'Request cancelled'})
      : super(prefix: 'Request Cancelled: ');
}

// ─────────────────────────────────────────────────────────────────────────────
// Cache-related exceptions
// ─────────────────────────────────────────────────────────────────────────────

class CacheException extends AppException {
  CacheException({super.message = 'Cache error'})
      : super(prefix: 'Cache Error: ');
}
