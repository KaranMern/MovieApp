import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sample/core/network/alice_provider.dart';

/// Provides a configured [Dio] instance: Alice interceptor (when SIT) and
/// [PrettyDioLogger] for request/response logging.
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final alice = ref.watch(aliceProvider);

  if (alice != null) {
    dio.interceptors.add(alice.getDioInterceptor());
  }

  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ),
  );

  return dio;
});
