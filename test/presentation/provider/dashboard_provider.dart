// lib/features/dashboard/presentation/dashboard_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/features/Movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/Movies/domain/repositories/get_movies_repository_impl.dart';


final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});

class DashboardNotifier extends AsyncNotifier<MovieEntity> {
  List<ResultEntity> _allResults = [];

  @override
  Future<MovieEntity> build() async {
    return MovieEntity(page: 0, results: [], totalPages: 0, totalResults: 0);
  }

  Future<void> fetchProducts({int? page, String? filter}) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(dashboardRepositoryProvider);
      final newData = await repo.fetchProducts(page: page, filter: filter);

      if (page == 1) _allResults = [];
      _allResults = [..._allResults, ...?newData.results];

      state = AsyncData(newData.copyWith(results: _allResults));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final dashboardNotifierProvider =
AsyncNotifierProvider<DashboardNotifier, MovieEntity>(DashboardNotifier.new);