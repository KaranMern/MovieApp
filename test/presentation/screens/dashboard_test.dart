// test/presentation/screens/dashboard_test.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/core/constants/key_constants.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/domain/repositories/get_movies_repository_impl.dart';
import 'package:sample/features/movies/presentation/Screens/dashboard.dart';
import 'package:sample/features/movies/presentation/dashboard_providers.dart';
import 'package:sample/features/movies/providers/dashboard_notifier.dart';

/// Fake repository that always returns the same [MovieEntity] (no network).
class _FakeRepository implements DashboardRepository {
  _FakeRepository(this.data);
  final MovieEntity data;

  @override
  Future<MovieEntity> fetchProducts({int? page, String? filter}) async {
    return data;
  }
}

/// Repository that throws on every fetch (used for error-state tests).
class _ThrowingRepository implements DashboardRepository {
  @override
  Future<MovieEntity> fetchProducts({int? page, String? filter}) async {
    throw Exception('Something went wrong');
  }
}

/// Notifier that never completes build (stays in loading).
class _LoadingNotifier extends DashboardNotifier {
  @override
  Future<MovieEntity> build() async {
    await Completer<void>().future;
    throw Exception('unreachable');
  }
}

/// Notifier that returns [fakeData] immediately and simulates refresh with same data.
class _FakeDashboardNotifier extends DashboardNotifier {
  _FakeDashboardNotifier(this.fakeData);
  final MovieEntity fakeData;

  @override
  Future<MovieEntity> build() async => fakeData;

  @override
  Future<void> refreshMovies({String? filter}) async {
    state = const AsyncLoading();
    state = AsyncData(fakeData);
  }
}

/// Notifier that fails during build (emits AsyncError).
class _DirectErrorNotifier extends DashboardNotifier {
  @override
  Future<MovieEntity> build() async {
    await Future.microtask(() {});
    throw Exception('Something went wrong');
  }
}

/// Builds a [GoRouter] with dashboard at '/' and detail sub-route for navigation tests.
GoRouter _makeRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: 'DetailScreen',
            builder: (_, state) => Scaffold(
              body: Text(
                'Detail: ${(state.extra as ResultEntity?)?.title ?? ''}',
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

/// Wraps the app with [ProviderScope] and optional overrides; uses [_makeRouter].
Widget _wrap(List<Override> overrides) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp.router(routerConfig: _makeRouter()),
  );
}

/// Pumps and settles so async state (e.g. Riverpod build) is applied.
Future<void> pumpSettle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  const tMovieEntity = MovieEntity(
    page: 1,
    totalPages: 2,
    totalResults: 20,
    results: [
      ResultEntity(
        id: 1,
        title: 'Avengers',
        posterPath: '/poster.jpg',
        releaseDate: '2024-04-01',
        voteAverage: 8.5,
        adult: false,
        video: false,
        genreIds: [28],
        popularity: 100,
      ),
    ],
  );

  testWidgets('shows loading indicator while loading', (tester) async {
    await tester.pumpWidget(
      _wrap([
        dashboardRepositoryProvider.overrideWithValue(
          _FakeRepository(tMovieEntity),
        ),
        dashboardNotifierProvider.overrideWith(_LoadingNotifier.new),
      ]),
    );

    await tester.pump();

    expect(find.byKey(KeyConstants.loadingIndicator), findsOneWidget);
  });

  testWidgets('shows movie grid when data is loaded', (tester) async {
    await tester.pumpWidget(
      _wrap([
        dashboardRepositoryProvider.overrideWithValue(
          _FakeRepository(tMovieEntity),
        ),
        dashboardNotifierProvider.overrideWith(
          () => _FakeDashboardNotifier(tMovieEntity),
        ),
      ]),
    );

    await pumpSettle(tester);

    expect(find.byKey(KeyConstants.movieCard), findsWidgets);
    expect(find.text('Avengers'), findsOneWidget);
  });

  testWidgets('shows no data text when results are empty', (tester) async {
    const emptyEntity = MovieEntity(
      page: 1,
      totalPages: 1,
      totalResults: 0,
      results: [],
    );

    await tester.pumpWidget(
      _wrap([
        dashboardRepositoryProvider.overrideWithValue(
          _FakeRepository(emptyEntity),
        ),
        dashboardNotifierProvider.overrideWith(
          () => _FakeDashboardNotifier(emptyEntity),
        ),
      ]),
    );

    await pumpSettle(tester);

    expect(find.textContaining('No'), findsOneWidget);
  });

  testWidgets('tapping movie card navigates to detail screen', (tester) async {
    await tester.pumpWidget(
      _wrap([
        dashboardRepositoryProvider.overrideWithValue(
          _FakeRepository(tMovieEntity),
        ),
        dashboardNotifierProvider.overrideWith(
          () => _FakeDashboardNotifier(tMovieEntity),
        ),
      ]),
    );

    await pumpSettle(tester);

    await tester.tap(find.byKey(KeyConstants.movieCard).first);
    await pumpSettle(tester);

    expect(find.textContaining('Detail:'), findsOneWidget);
  });

  testWidgets('shows RefreshIndicator wrapping grid', (tester) async {
    await tester.pumpWidget(
      _wrap([
        dashboardRepositoryProvider.overrideWithValue(
          _FakeRepository(tMovieEntity),
        ),
        dashboardNotifierProvider.overrideWith(
          () => _FakeDashboardNotifier(tMovieEntity),
        ),
      ]),
    );

    await pumpSettle(tester);

    expect(find.byType(RefreshIndicator), findsOneWidget);
  });
}
