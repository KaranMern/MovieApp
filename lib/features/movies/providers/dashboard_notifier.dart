import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/domain/repositories/get_movies_repository_impl.dart';
import 'package:sample/features/movies/presentation/dashboard_providers.dart';

/// Async notifier that holds paginated [MovieEntity] state, loads initial data
/// in [build], and supports refresh and load-more (infinite scroll).
class DashboardNotifier extends AsyncNotifier<MovieEntity> {
  late DashboardRepository dashboardRepository;

  int _currentPage = 1;
  String _movieFilter = 'top_rated';
  bool _isLoadingMore = false;

  @override
  Future<MovieEntity> build() async {
    dashboardRepository = ref.read(dashboardRepositoryProvider);
    return fetch(page: 1, filter: _movieFilter);
  }

  /// Fetches a single page and updates internal page/filter. Caller must
  /// assign [state] (e.g. [refreshMovies] or [loadMore]).
  Future<MovieEntity> fetch({required int page, required String filter}) async {
    final response = await dashboardRepository.fetchProducts(
      page: page,
      filter: filter,
    );

    _currentPage = page;
    _movieFilter = filter;

    return response;
  }

  /// Resets to page 1, optionally with new [filter], sets loading then
  /// data or error state.
  Future<void> refreshMovies({String? filter}) async {
    _currentPage = 1;
    _movieFilter = filter ?? _movieFilter;

    state = const AsyncLoading();

    try {
      final response = await fetch(page: 1, filter: _movieFilter);

      state = AsyncData(response);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Appends next page of results to current state. No-op if already loading,
  /// no current data, or already at last page. Sets [AsyncError] on failure.
  Future<void> loadMore() async {
    if (_isLoadingMore) return;

    final currentState = state.value;
    if (currentState == null) return;

    if (_currentPage >= (currentState.totalPages ?? 1)) return;

    _isLoadingMore = true;

    try {
      final nextPage = _currentPage + 1;

      final response = await dashboardRepository.fetchProducts(
        page: nextPage,
        filter: _movieFilter,
      );

      final updatedResults = [...?currentState.results, ...?response.results];

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
    } finally {
      _isLoadingMore = false;
    }
  }
}
