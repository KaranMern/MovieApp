import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample/core/network/secure_storage.dart';
import 'package:sample/features/movies/data/datasources/remote_data_source.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:sample/features/movies/data/models/movie_detail.dart';
import 'remote_data_source_test.mocks.dart';

@GenerateMocks([Dio, SecureStorageBase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MoviesDataSource dataSource;
  late MockSecureStorageBase mockSecureStorage;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    mockSecureStorage = MockSecureStorageBase();
    dataSource = MoviesDataSource(
      Apidio: mockDio,
      secureStorageBase: mockSecureStorage,
    );
    when(mockSecureStorage.getValue(any)).thenAnswer((_) async => 'fake_token');
  });

  final tResponseData = {
    'page': 1,
    'results': [
      {
        'adult': false,
        'backdrop_path': '/path.jpg',
        'genre_ids': [28],
        'id': 1,
        'original_language': 'en',
        'original_title': 'Test',
        'overview': 'Overview',
        'popularity': 9.0,
        'poster_path': '/poster.jpg',
        'release_date': '2024-01-01',
        'title': 'Test Movie',
        'video': false,
        'vote_average': 8.0,
        'vote_count': 100,
      },
    ],
    'total_pages': 3,
    'total_results': 60,
  };
  final fakeResponseData = {
    'page': 1,
    'results': [
      {'video': false, 'vote_average': 8.0, 'vote_count': 100},
    ],
    'total_pages': 3,
    'total_results': 60,
  };

  group('getMovies', () {
    test('returns MovieDetail on HTTP 200', () async {
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: tResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await dataSource.getMovies(page: 1, filter: 'popular');

      expect(result, isA<MovieDetail>());
      expect(result.page, 1);
      expect(result.results!.length, 1);
    });
    test('throws Exception when response structure is invalid', () async {
      // Given
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: fakeResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // When
      final call = dataSource.getMovies(page: 1, filter: 'popular');

      // Then
      expect(call, throwsException);
    });
    test('throws Exception when status code is not 200', () async {
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: null,
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(
        () => dataSource.getMovies(page: 1, filter: 'popular'),
        throwsException,
      );
    });

    test('throws Exception on DioException', () async {
      when(
        mockDio.get(any, options: anyNamed('options')),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(
        () => dataSource.getMovies(page: 1, filter: 'popular'),
        throwsException,
      );
    });
  });
}
