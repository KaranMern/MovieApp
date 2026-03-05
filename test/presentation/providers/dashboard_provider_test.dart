// test/presentation/provider/dashboard_provider_test.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/domain/repositories/get_movies_repository_impl.dart';
import 'package:sample/features/movies/presentation/dashboard_providers.dart';

import 'dashboard_provider_test.mocks.dart';

/// Unit tests for [DashboardNotifier]. Uses a [ProviderContainer] with
/// overridden [dashboardRepositoryProvider]. Covers: initial build state,
/// refreshMovies (success, failure, default filter, reset to page 1), loadMore
/// (append, multiple pages, failure, last page no-op, null/empty results).
@GenerateMocks([DashboardRepository])
void main() {
  late MockDashboardRepository mockRepository;
  late ProviderContainer container;

  const tMovieEntity = MovieEntity(
    page: 1,
    totalPages: 3,
    totalResults: 60,
    results: [
      ResultEntity(
        id: 1,
        title: 'Test Movie',
        posterPath: '/poster.jpg',
        releaseDate: '2024-01-01',
        voteAverage: 8,
        adult: false,
        video: false,
        genreIds: [28],
        popularity: 9,
      ),
    ],
  );

  const tPage2Entity = MovieEntity(
    page: 2,
    totalPages: 3,
    totalResults: 60,
    results: [
      ResultEntity(
        id: 2,
        title: 'Movie 2',
        posterPath: '/p2.jpg',
        releaseDate: '2024-02-01',
        voteAverage: 7,
      ),
    ],
  );

  const tPage3Entity = MovieEntity(
    page: 3,
    totalPages: 3,
    totalResults: 60,
    results: [
      ResultEntity(
        id: 3,
        title: 'Movie 3',
        posterPath: '/p3.jpg',
        releaseDate: '2024-03-01',
        voteAverage: 6,
      ),
    ],
  );

  setUp(() {
    mockRepository = MockDashboardRepository();
    when(mockRepository.fetchProducts(
      page: anyNamed('page'),
      filter: anyNamed('filter'),
    )).thenAnswer((_) async => tMovieEntity);

    container = ProviderContainer(
      overrides: [
        dashboardRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
    addTearDown(container.dispose);
  });

  group('DashboardNotifier Tests', () {
    test('initial state is AsyncData after build completes', () async {
      await container.read(dashboardNotifierProvider.future);

      final state = container.read(dashboardNotifierProvider);
      expect(state, isA<AsyncData<MovieEntity>>());
      expect(state.value?.results?.length, 1);
    });

    test('refreshMovies emits AsyncData on success', () async {
      await container.read(dashboardNotifierProvider.future);

      when(mockRepository.fetchProducts(page: 1, filter: 'popular'))
          .thenAnswer((_) async => tMovieEntity);

      await container
          .read(dashboardNotifierProvider.notifier)
          .refreshMovies(filter: 'popular');

      final state = container.read(dashboardNotifierProvider);
      expect(state, isA<AsyncData<MovieEntity>>());
      expect(state.value?.results?.length, 1);
      expect(state.value?.results?.first.title, 'Test Movie');
    });

    test('refreshMovies emits AsyncError on failure', () async {
      await container.read(dashboardNotifierProvider.future);

      when(mockRepository.fetchProducts(
        page: anyNamed('page'),
        filter: anyNamed('filter'),
      )).thenAnswer((_) async => throw Exception('Server error'));

      await container
          .read(dashboardNotifierProvider.notifier)
          .refreshMovies(filter: 'popular');

      final state = container.read(dashboardNotifierProvider);
      expect(state, isA<AsyncError>());
    });

    test('refreshMovies uses current filter when none provided', () async {
      await container.read(dashboardNotifierProvider.future);

      await container
          .read(dashboardNotifierProvider.notifier)
          .refreshMovies();

      verify(mockRepository.fetchProducts(
        page: 1,
        filter: 'top_rated',
      )).called(greaterThanOrEqualTo(1));
    });

    test('refreshMovies resets accumulated results on page 1', () async {
      await container.read(dashboardNotifierProvider.future);

      when(mockRepository.fetchProducts(page: 2, filter: anyNamed('filter')))
          .thenAnswer((_) async => tPage2Entity);
      await container.read(dashboardNotifierProvider.notifier).loadMore();
      expect(container.read(dashboardNotifierProvider).value?.results?.length, 2);

      when(mockRepository.fetchProducts(page: 1, filter: anyNamed('filter')))
          .thenAnswer((_) async => tMovieEntity);
      await container
          .read(dashboardNotifierProvider.notifier)
          .refreshMovies();

      final state = container.read(dashboardNotifierProvider);
      expect(state.value?.results?.length, 1);
      expect(state.value?.results?.first.id, 1);
    });

    test('loadMore appends results to existing list', () async {
      await container.read(dashboardNotifierProvider.future);

      when(mockRepository.fetchProducts(page: 2, filter: anyNamed('filter')))
          .thenAnswer((_) async => tPage2Entity);

      await container.read(dashboardNotifierProvider.notifier).loadMore();

      final state = container.read(dashboardNotifierProvider);
      expect(state.value?.results?.length, 2);
      expect(state.value?.results?[0].id, 1);
      expect(state.value?.results?[1].id, 2);
    });

    test('loadMore appends correctly across multiple pages', () async {
      await container.read(dashboardNotifierProvider.future);

      when(mockRepository.fetchProducts(page: 2, filter: anyNamed('filter')))
          .thenAnswer((_) async => tPage2Entity);
      when(mockRepository.fetchProducts(page: 3, filter: anyNamed('filter')))
          .thenAnswer((_) async => tPage3Entity);

      await container.read(dashboardNotifierProvider.notifier).loadMore();
      await container.read(dashboardNotifierProvider.notifier).loadMore();

      final state = container.read(dashboardNotifierProvider);
      expect(state.value?.results?.length, 3);
      expect(state.value?.results?[0].id, 1);
      expect(state.value?.results?[1].id, 2);
      expect(state.value?.results?[2].id, 3);
    });

    test('loadMore emits AsyncError on failure', () async {
      await container.read(dashboardNotifierProvider.future);

      when(mockRepository.fetchProducts(page: 2, filter: anyNamed('filter')))
          .thenAnswer((_) async => throw Exception('Load more failed'));

      await container.read(dashboardNotifierProvider.notifier).loadMore();

      final state = container.read(dashboardNotifierProvider);
      expect(state, isA<AsyncError>());
    });

    test('loadMore does nothing when already on last page', () async {
      await container.read(dashboardNotifierProvider.future);

      when(mockRepository.fetchProducts(page: 2, filter: anyNamed('filter')))
          .thenAnswer((_) async => tPage2Entity);
      when(mockRepository.fetchProducts(page: 3, filter: anyNamed('filter')))
          .thenAnswer((_) async => tPage3Entity);

      await container.read(dashboardNotifierProvider.notifier).loadMore();
      await container.read(dashboardNotifierProvider.notifier).loadMore();

      clearInteractions(mockRepository);

      await container.read(dashboardNotifierProvider.notifier).loadMore();

      verifyNever(mockRepository.fetchProducts(
        page: anyNamed('page'),
        filter: anyNamed('filter'),
      ));
    });

    test('loadMore handles null results from current state safely', () async {
      const nullResultsEntity = MovieEntity(
        page: 1,
        totalPages: 3,
        totalResults: 60,
      );

      when(mockRepository.fetchProducts(
        page: anyNamed('page'),
        filter: anyNamed('filter'),
      )).thenAnswer((_) async => nullResultsEntity);

      await container.read(dashboardNotifierProvider.future);

      when(mockRepository.fetchProducts(page: 2, filter: anyNamed('filter')))
          .thenAnswer((_) async => tPage2Entity);

      await container.read(dashboardNotifierProvider.notifier).loadMore();

      final state = container.read(dashboardNotifierProvider);
      expect(state.value?.results?.length, 1);
      expect(state.value?.results?.first.id, 2);
    });

    test('loadMore handles empty results from response safely', () async {
      await container.read(dashboardNotifierProvider.future);

      const emptyResponseEntity = MovieEntity(
        page: 2,
        totalPages: 3,
        totalResults: 60,
        results: [],
      );

      when(mockRepository.fetchProducts(page: 2, filter: anyNamed('filter')))
          .thenAnswer((_) async => emptyResponseEntity);

      await container.read(dashboardNotifierProvider.notifier).loadMore();

      final state = container.read(dashboardNotifierProvider);
      expect(state.value?.results?.length, 1);
      expect(state.value?.results?.first.id, 1);
    });
  });
}
