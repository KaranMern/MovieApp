// test/domain/repositories/dashboard_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample/features/movies/data/datasources/remote_data_source.dart';
import 'package:sample/features/movies/data/models/movie_detail.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/domain/repositories/get_movies_repository_impl.dart';

import 'dashboard_repository_test.mocks.dart';

@GenerateMocks([DashboardDataSource])
void main() {
  late DashboardRepositoryImpl repository;
  late MockDashboardDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockDashboardDataSource();
    repository = DashboardRepositoryImpl(mockDataSource);
  });

  final tMovieDetail = MovieDetail(
    page: 1,
    totalPages: 5,
    totalResults: 100,
    results: [
      Results(
        id: 1,
        title: 'Test Movie',
        adult: false,
        backdropPath: '/back.jpg',
        genreIds: [28],
        originalLanguage: 'en',
        originalTitle: 'Test',
        overview: 'Overview',
        popularity: 9.0,
        posterPath: '/poster.jpg',
        releaseDate: '2024-01-01',
        video: false,
        voteAverage: 8.5,
        voteCount: 200,
      )
    ],
  );

  group('fetchProducts', () {
    test('returns MovieEntity mapped from MovieDetail model', () async {
      when(mockDataSource.getMovies(page: anyNamed('page'), filter: anyNamed('filter')))
          .thenAnswer((_) async => tMovieDetail);

      final result = await repository.fetchProducts(page: 1, filter: 'popular');

      expect(result, isA<MovieEntity>());
      expect(result.page, 1);
      expect(result.totalPages, 5);
      expect(result.results!.length, 1);
      expect(result.results!.first.title, 'Test Movie');
      expect(result.results!.first.id, 1);
    });

    test('maps all ResultEntity fields correctly', () async {
      when(mockDataSource.getMovies(page: anyNamed('page'), filter: anyNamed('filter')))
          .thenAnswer((_) async => tMovieDetail);

      final result = await repository.fetchProducts(page: 1, filter: 'popular');
      final firstResult = result.results!.first;

      expect(firstResult.adult, false);
      expect(firstResult.voteAverage, 8.5);
      expect(firstResult.genreIds, [28]);
      expect(firstResult.posterPath, '/poster.jpg');
    });

    test('throws exception when data source fails', () async {
      when(mockDataSource.getMovies(page: anyNamed('page'), filter: anyNamed('filter')))
          .thenThrow(Exception('Network error'));

      expect(
            () => repository.fetchProducts(page: 1, filter: 'popular'),
        throwsException,
      );
    });

    test('handles empty results list', () async {
      when(mockDataSource.getMovies(page: anyNamed('page'), filter: anyNamed('filter')))
          .thenAnswer((_) async => MovieDetail(
        page: 1,
        totalPages: 1,
        totalResults: 0,
        results: [],
      ));

      final result = await repository.fetchProducts(page: 1, filter: 'popular');

      expect(result.results, isEmpty);
    });
  });
}
