// test/presentation/dashboard_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample/core/constants/key_constants.dart';
import 'package:sample/features/Movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/Movies/presentation/Screens/dashboard.dart';
import 'package:sample/features/Movies/presentation/Screens/detail_screen.dart';
import '../provider/dashboard_provider.dart';

abstract class fakeDashboardNotifier{
  Future<void> fetchProducts();
  Future<void> _ErrorNotifier();
}
class FakeDashboardNotifier extends DashboardNotifier {
  final MovieEntity _fakeData;
  FakeDashboardNotifier(this._fakeData);

  @override
  Future<MovieEntity> build() async => _fakeData;

  @override
  Future<void> fetchProducts({int? page, String? filter}) async {
    state = AsyncData(_fakeData);
  }
}

void main() {
  final tMovieEntity = MovieEntity(
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
        popularity: 100.0,
      ),
    ],
  );

  Widget buildTestWidget(MovieEntity entity) {
    return ProviderScope(
      overrides: [
        dashboardNotifierProvider.overrideWith(
          () => FakeDashboardNotifier(entity),
        ),
      ],
      child: const MaterialApp(home: DashboardScreen()),
    );
  }

  testWidgets('shows loading indicator while loading', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dashboardNotifierProvider.overrideWith(
            () => FakeDashboardNotifier(MovieEntity(results: null)),
          ),
        ],
        child: const MaterialApp(home: DashboardScreen()),
      ),
    );

    await tester.pump();
    expect(find.byKey(KeyConstants.loadingIndicator), findsOneWidget);
  });

  testWidgets('shows movie grid when data is loaded', (tester) async {
    await tester.pumpWidget(buildTestWidget(tMovieEntity));
    await tester.pumpAndSettle();

    expect(find.byKey(KeyConstants.movieGrid), findsOneWidget);

    expect(find.byKey(const Key('movie_card_1')), findsOneWidget);

    expect(find.text('Avengers'), findsOneWidget);
  });

  testWidgets('shows no data text when results are empty', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        MovieEntity(page: 1, totalPages: 1, totalResults: 0, results: []),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(KeyConstants.noDataText), findsOneWidget);
  });

  testWidgets('shows error text on error state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dashboardNotifierProvider.overrideWith(() => _ErrorNotifier()),
        ],
        child: const MaterialApp(home: DashboardScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(KeyConstants.errorText), findsOneWidget);
  });

  testWidgets('tapping movie card navigates to detail screen', (tester) async {
    await tester.pumpWidget(buildTestWidget(tMovieEntity));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('movie_card_1')));
    await tester.pumpAndSettle();

    expect(find.byType(Detailscreen), findsOneWidget);
  });

  testWidgets('shows refresh indicator wrapping grid', (tester) async {
    await tester.pumpWidget(buildTestWidget(tMovieEntity));
    await tester.pumpAndSettle();

    expect(find.byKey(KeyConstants.refreshIndicator), findsOneWidget);
  });
}

class _ErrorNotifier extends DashboardNotifier {
  @override
  Future<MovieEntity> build() async {
    throw Exception('Something went wrong');
  }

  @override
  Future<void> fetchProducts({int? page, String? filter}) async {
    state = AsyncError(Exception('Something went wrong'), StackTrace.current);
  }
}
