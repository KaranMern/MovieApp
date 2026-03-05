// test/domain/repositories/dashboard_repository_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample/features/movies/data/datasources/remote_data_source.dart';
import 'package:sample/features/movies/data/models/movie_detail.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/domain/repositories/get_movies_repository_impl.dart';

import 'dashboard_repository_test.mocks.dart';

/// Unit tests for [DashboardRepositoryImpl]. Mocks [DashboardDataSource] to
/// verify fetchProducts delegates with correct params and maps [MovieDetail]
/// to [MovieEntity]/[ResultEntity] correctly; includes empty results and
/// exception propagation.
@GenerateMocks([DashboardDataSource])
void main() {
  late DashboardRepositoryImpl repository;
  late MockDashboardDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockDashboardDataSource();
    repository = DashboardRepositoryImpl(mockDataSource);
  });

  /// Shared model fixture for successful API response.
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
        popularity: 9,
        posterPath: '/poster.jpg',
        releaseDate: '2024-01-01',
        video: false,
        voteAverage: 8.5,
        voteCount: 200,
      ),
    ],
  );

  group('fetchProducts', () {
    test('✔ calls datasource with correct parameters', () async {
      when(
        mockDataSource.getMovies(
          page: anyNamed('page'),
          filter: anyNamed('filter'),
        ),
      ).thenAnswer((_) async => tMovieDetail);

      await repository.fetchProducts(page: 2, filter: 'top_rated');

      verify(mockDataSource.getMovies(page: 2, filter: 'top_rated')).called(1);
    });

    test('✔ returns MovieEntity mapped from MovieDetail model', () async {
      when(
        mockDataSource.getMovies(
          page: anyNamed('page'),
          filter: anyNamed('filter'),
        ),
      ).thenAnswer((_) async => tMovieDetail);

      final result = await repository.fetchProducts(page: 1, filter: 'popular');

      expect(result, isA<MovieEntity>());
      expect(result.page, 1);
      expect(result.totalPages, 5);
      expect(result.results!.length, 1);
      expect(result.results!.first.title, 'Test Movie');
      expect(result.results!.first.id, 1);
    });

    test('✔ maps all ResultEntity fields correctly', () async {
      when(
        mockDataSource.getMovies(
          page: anyNamed('page'),
          filter: anyNamed('filter'),
        ),
      ).thenAnswer((_) async => tMovieDetail);

      final result = await repository.fetchProducts(page: 1, filter: 'popular');

      final first = result.results!.first;

      expect(first.adult, false);
      expect(first.voteAverage, 8.5);
      expect(first.genreIds, [28]);
      expect(first.posterPath, '/poster.jpg');
      expect(first.releaseDate, '2024-01-01');
      expect(first.voteCount, 200);
    });

    test('✔ handles empty results list', () async {
      when(
        mockDataSource.getMovies(
          page: anyNamed('page'),
          filter: anyNamed('filter'),
        ),
      ).thenAnswer(
        (_) async =>
            MovieDetail(page: 1, totalPages: 1, totalResults: 0, results: []),
      );

      final result = await repository.fetchProducts(page: 1, filter: 'popular');

      expect(result.results, isEmpty);
      expect(result.totalResults, 0);
    });

    test('✔ handles multiple results mapping correctly', () async {
      when(
        mockDataSource.getMovies(
          page: anyNamed('page'),
          filter: anyNamed('filter'),
        ),
      ).thenAnswer(
        (_) async => MovieDetail(
          page: 1,
          totalPages: 1,
          totalResults: 2,
          results: [
            tMovieDetail.results!.first,
            Results(
              id: 2,
              title: tMovieDetail.results!.first.title,
              adult: tMovieDetail.results!.first.adult,
              backdropPath: tMovieDetail.results!.first.backdropPath,
              genreIds: tMovieDetail.results!.first.genreIds,
              originalLanguage: tMovieDetail.results!.first.originalLanguage,
              originalTitle: tMovieDetail.results!.first.originalTitle,
              overview: tMovieDetail.results!.first.overview,
              popularity: tMovieDetail.results!.first.popularity,
              posterPath: tMovieDetail.results!.first.posterPath,
              releaseDate: tMovieDetail.results!.first.releaseDate,
              video: tMovieDetail.results!.first.video,
              voteAverage: tMovieDetail.results!.first.voteAverage,
              voteCount: tMovieDetail.results!.first.voteCount,
            ),
          ],
        ),
      );

      final result = await repository.fetchProducts(page: 1, filter: 'popular');

      expect(result.results!.length, 2);
      expect(result.results![1].id, 2);
    });

    test('✔ propagates exception when datasource fails', () async {
      when(
        mockDataSource.getMovies(
          page: anyNamed('page'),
          filter: anyNamed('filter'),
        ),
      ).thenThrow(Exception('Network error'));

      expect(
        () => repository.fetchProducts(page: 1, filter: 'popular'),
        throwsException,
      );
    });
  });
}
