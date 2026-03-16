// test/data/datasources/remote_data_source_test.dart

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample/features/movies/data/datasources/remote_data_source.dart';
import 'package:sample/features/movies/data/models/movie_detail.dart';

import 'remote_data_source_test.mocks.dart';

/// Unit tests for [MoviesDataSource]. Mocks [Dio] to verify correct API calls
/// and response handling (success, non-200, missing data, DioException).
@GenerateMocks([Dio])
void main() {
  late MoviesDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = MoviesDataSource(apidio: mockDio, apiToken: 'fake_test_token');
  });

  /// Sample response matching TMDB movie list API structure.
  final validResponse = {
    'page': 1,
    'results': [
      {
        'id': 1,
        'title': 'Test Movie',
        'poster_path': '/poster.jpg',
        'vote_average': 8.0,
        'genre_ids': [28, 12],
      },
    ],
    'total_pages': 3,
    'total_results': 60,
  };

  group('getMovies()', () {
    test('✔ returns MovieDetail on success', () async {
      when(
        mockDio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: validResponse,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await dataSource.getMovies(page: 1, filter: 'popular');

      expect(result, isA<MovieDetail>());
      expect(result.results!.length, 1);
    });

    test('✔ verifies correct endpoint is called', () async {
      when(
        mockDio.get(
          any,
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: validResponse,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      await dataSource.getMovies(page: 2, filter: 'popular');

      verify(
        mockDio.get(
          'https://api.themoviedb.org/3/movie/popular?page=2',
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('✔ throws when status code is not 200', () async {
      when(
        mockDio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          statusCode: 404,
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        () => dataSource.getMovies(page: 1, filter: 'popular'),
        throwsException,
      );
    });

    test('✔ throws when response body is null', () async {
      when(
        mockDio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        () => dataSource.getMovies(page: 1, filter: 'popular'),
        throwsException,
      );
    });

    test('✔ throws when results field is missing', () async {
      when(
        mockDio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {'page': 1},
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        () => dataSource.getMovies(page: 1, filter: 'popular'),
        throwsException,
      );
    });

    test('✔ handles empty results list', () async {
      when(
        mockDio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {
            'page': 1,
            'results': [],
            'total_pages': 1,
            'total_results': 0,
          },
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await dataSource.getMovies(page: 1, filter: 'popular');

      expect(result.results, isEmpty);
    });

    test('✔ throws on DioException', () async {
      when(
        mockDio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      expect(
        () => dataSource.getMovies(page: 1, filter: 'popular'),
        throwsException,
      );
    });
  });
}
