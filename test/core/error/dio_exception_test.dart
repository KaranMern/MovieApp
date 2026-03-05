// test/core/error/dio_exception_test.dart

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample/core/error/dio_exception.dart';
import 'package:sample/core/error/exception.dart';

/// Unit tests for [DioExceptionMapper]. Ensures each [DioExceptionType] and
/// HTTP status code (400, 401, 403, 404, 500, other) maps to the correct
/// [AppException] subclass with expected message where applicable.
void main() {
  group('DioExceptionMapper', () {
    test('maps connectionTimeout, sendTimeout, receiveTimeout to TimeoutException', () {
      final exceptions = [
        DioException(requestOptions: RequestOptions(), type: DioExceptionType.connectionTimeout),
        DioException(requestOptions: RequestOptions(), type: DioExceptionType.sendTimeout),
        DioException(requestOptions: RequestOptions(), type: DioExceptionType.receiveTimeout),
      ];

      for (final e in exceptions) {
        final result = DioExceptionMapper.map(e);
        expect(result, isA<TimeoutException>());
      }
    });

    test('maps connectionError to NetworkException', () {
      final e = DioException(requestOptions: RequestOptions(), type: DioExceptionType.connectionError);
      final result = DioExceptionMapper.map(e);
      expect(result, isA<NetworkException>());
    });

    test('maps cancel to RequestCancelledException', () {
      final e = DioException(requestOptions: RequestOptions(), type: DioExceptionType.cancel);
      final result = DioExceptionMapper.map(e);
      expect(result, isA<RequestCancelledException>());
    });

    group('maps badResponse with different status codes', () {
      test('400 returns BadRequestException with message', () {
        final e = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 400,
            data: {'message': 'Invalid request'},
          ),
        );
        final result = DioExceptionMapper.map(e);
        expect(result, isA<BadRequestException>());
        expect(result.message, 'Invalid request');
      });

      test('401 returns UnauthorizedException', () {
        final e = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: RequestOptions(), statusCode: 401),
        );
        final result = DioExceptionMapper.map(e);
        expect(result, isA<UnauthorizedException>());
      });

      test('403 returns ForbiddenException', () {
        final e = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: RequestOptions(), statusCode: 403),
        );
        final result = DioExceptionMapper.map(e);
        expect(result, isA<ForbiddenException>());
      });

      test('404 returns NotFoundException', () {
        final e = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: RequestOptions(), statusCode: 404),
        );
        final result = DioExceptionMapper.map(e);
        expect(result, isA<NotFoundException>());
      });

      test('500 returns ServerException', () {
        final e = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: RequestOptions(), statusCode: 500),
        );
        final result = DioExceptionMapper.map(e);
        expect(result, isA<ServerException>());
      });

      test('other status codes return ServerException with custom message', () {
        final e = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: RequestOptions(), statusCode: 502),
        );
        final result = DioExceptionMapper.map(e);
        expect(result, isA<ServerException>());
        expect(result.message, 'Server error: 502');
      });
    });

    test('unknown DioException maps to NetworkException with message', () {
      final e = DioException(requestOptions: RequestOptions(), message: 'Unknown failure');
      final result = DioExceptionMapper.map(e);
      expect(result, isA<NetworkException>());
      expect(result.message, 'Unknown failure');
    });
  });
}
