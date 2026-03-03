import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/entities/movie_detail_entity.dart';
import '../domain/repositories/get_movies_repository_impl.dart';
import '../presentation/dashboard_provider.dart';

// part  'dashboard_notifier.g.dart';

@riverpod
class DashboardNotifier extends AsyncNotifier<MovieEntity> {
  late DashboardRepository dashboardRepository;

  int _currentPage = 1;
  String _movieFilter = "top_rated";
  bool _isLoadingMore = false;

  @override
  Future<MovieEntity> build() async {
    dashboardRepository = ref.read(dashboardRepositoryProvider);
    return fetch(page: 1, filter: _movieFilter);
  }

  Future<MovieEntity> fetch({
    required int page,
    required String filter,
  }) async {
    final response =
    await dashboardRepository.fetchProducts(page: page, filter: filter);

    _currentPage = page;
    _movieFilter = filter;

    return response;
  }
  Future<void> refreshMovies({String? filter}) async {
    _currentPage = 1;
    _movieFilter = filter ?? _movieFilter;

    state = const AsyncLoading();

    try {
      final response =
      await fetch(page: 1, filter: _movieFilter);

      state = AsyncData(response);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadMore() async {
    if (_isLoadingMore) return;

    final currentState = state.value;
    if (currentState == null) return;

    if (_currentPage >= (currentState.totalPages ?? 1)) return;

    _isLoadingMore = true;

    try {
      final nextPage = _currentPage + 1;

      final response =
      await dashboardRepository.fetchProducts(
        page: nextPage,
        filter: _movieFilter,
      );

      final updatedResults = [
        ...?currentState.results,
        ...?response.results,
      ];

      final updatedMovieEntity = MovieEntity(
        page: response.page,
        results: updatedResults,
        totalPages: response.totalPages,
        totalResults: response.totalResults,
      );

      _currentPage = nextPage;

      state = AsyncData(updatedMovieEntity);
    } catch (e, st) {
      state = AsyncError(e, st);
    }

    _isLoadingMore = false;
  }
}