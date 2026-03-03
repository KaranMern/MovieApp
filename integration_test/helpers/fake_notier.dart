
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/providers/dashboard_notifier.dart'; // ✅ real notifier
import 'mock_data.dart';

class FakeDashboardNotifier extends DashboardNotifier {
  @override
  Future<MovieEntity> build() async => MockData.movieEntity;

  @override
  Future<MovieEntity> fetchProducts({
    required int page,
    required String filter,
  }) async {
    state = AsyncData(MockData.movieEntity);
    return MockData.movieEntity;
  }
}

// ✅ Define FakeErrorNotifier here — it was missing
class FakeErrorNotifier extends DashboardNotifier {
  @override
  Future<MovieEntity> build() async {
    throw Exception('Network Error');
  }

  @override
  Future<MovieEntity> fetchProducts({
    required int page,
    required String filter,
  }) async {
    state = AsyncError(Exception('Network Error'), StackTrace.current);
    throw Exception('Network Error');
  }
}

class FakeEmptyNotifier extends DashboardNotifier {
  @override
  Future<MovieEntity> build() async => MovieEntity(
    page: 1,
    totalPages: 1,
    totalResults: 0,
    results: [],
  );

  @override
  Future<MovieEntity> fetchProducts({
    required int page,
    required String filter,
  }) async {
    final empty = MovieEntity(
      page: 1,
      totalPages: 1,
      totalResults: 0,
      results: [],
    );
    state = AsyncData(empty);
    return empty;
  }
}