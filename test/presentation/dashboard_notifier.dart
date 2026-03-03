import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample/features/movies/domain/repositories/get_movies_repository_impl.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/presentation/dashboard_provider.dart';

import 'dashboard_notifier.mocks.dart';


@GenerateMocks([DashboardRepository])
void main() {
  late MockDashboardRepository mockRepository;
  late ProviderContainer container;

  final tMovieEntity = MovieEntity(
    page: 1,
    totalPages: 3,
    totalResults: 60,
    results: [
      ResultEntity(
        id: 1,
        title: 'Test Movie',
        posterPath: '/poster.jpg',
        releaseDate: '2024-01-01',
        voteAverage: 8.0,
        adult: false,
        video: false,
        genreIds: [28],
        popularity: 9.0,
      )
    ],
  );

  setUp(() {
    mockRepository = MockDashboardRepository();
    container = ProviderContainer(
      overrides: [
        dashboardRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
    addTearDown(container.dispose);
  });

  group('DashboardNotifier', () {
    test('initial state is AsyncData with empty results', () {
      final state = container.read(dashboardNotifierProvider);
      expect(state, isA<AsyncData<MovieEntity>>());
      expect(state.value?.results, isEmpty);
    });

    test('fetchProducts emits AsyncData on success', () async {
      when(mockRepository.fetchProducts(page: anyNamed('page'), filter: anyNamed('filter')))
          .thenAnswer((_) async => tMovieEntity);

      await container
          .read(dashboardNotifierProvider.notifier)
          .fetchProducts(page: 1, filter: 'popular');

      final state = container.read(dashboardNotifierProvider);
      expect(state, isA<AsyncData<MovieEntity>>());
      expect(state.value?.results?.length, 1);
      expect(state.value?.results?.first.title, 'Test Movie');
    });

    test('fetchProducts emits AsyncError on failure', () async {
      when(mockRepository.fetchProducts(page: anyNamed('page'), filter: anyNamed('filter')))
          .thenThrow(Exception('Server error'));

      await container
          .read(dashboardNotifierProvider.notifier)
          .fetchProducts(page: 1, filter: 'popular');

      final state = container.read(dashboardNotifierProvider);
      expect(state, isA<AsyncError>());
    });

    test('pagination accumulates results across pages', () async {
      final page2Entity = MovieEntity(
        page: 2,
        totalPages: 3,
        totalResults: 60,
        results: [
          ResultEntity(id: 2, title: 'Movie 2', posterPath: '/p2.jpg', releaseDate: '2024-02-01', voteAverage: 7.0),
        ],
      );

      when(mockRepository.fetchProducts(page: 1, filter: anyNamed('filter')))
          .thenAnswer((_) async => tMovieEntity);
      when(mockRepository.fetchProducts(page: 2, filter: anyNamed('filter')))
          .thenAnswer((_) async => page2Entity);

      final notifier = container.read(dashboardNotifierProvider.notifier);
      await notifier.fetchProducts(page: 1, filter: 'popular');
      await notifier.fetchProducts(page: 2, filter: 'popular');

      final state = container.read(dashboardNotifierProvider);
      expect(state.value?.results?.length, 2);
    });

    test('page reset clears old results on page 1', () async {
      when(mockRepository.fetchProducts(page: anyNamed('page'), filter: anyNamed('filter')))
          .thenAnswer((_) async => tMovieEntity);

      final notifier = container.read(dashboardNotifierProvider.notifier);
      await notifier.fetchProducts(page: 2, filter: 'popular');
      await notifier.fetchProducts(page: 1, filter: 'popular');

      final state = container.read(dashboardNotifierProvider);
      expect(state.value?.results?.length, 1);
    });
  });
}