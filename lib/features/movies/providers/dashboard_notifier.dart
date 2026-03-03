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
  String Moviefilter = "top_rated";
  @override
  Future<MovieEntity> build() async {
    dashboardRepository = ref.read(dashboardRepositoryProvider);
    return fetchProducts(page: _currentPage, filter: Moviefilter);
  }

  Future<MovieEntity> fetchProducts({
    required int page,
    required String filter,
  }) async {
    try {
      final previousData = state.value;

      if (page == 1) {
        state = const AsyncValue.loading();
      }

      final response = await dashboardRepository.fetchProducts(page: page,filter: filter);

      _currentPage = page;
      Moviefilter = filter;

      if (previousData == null || page == 1) {
        state = AsyncValue.data(response);
        return response;
      } else {
        final updatedResults = [...?previousData.results, ...?response.results];

        final updatedMovieEntity = MovieEntity(
          page: response.page,
          results: updatedResults,
          totalPages: response.totalPages,
          totalResults: response.totalResults,
        );

        state = AsyncValue.data(updatedMovieEntity);
        return updatedMovieEntity;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
