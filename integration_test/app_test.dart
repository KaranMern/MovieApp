import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:sample/core/constants/key_constants.dart';
import 'package:sample/features/movies/presentation/Screens/dashboard.dart';
import 'package:sample/features/movies/presentation/Screens/detail_screen.dart';

import 'package:sample/features/movies/presentation/dashboard_providers.dart';
import 'package:sample/features/movies/providers/dashboard_notifier.dart';

import 'helpers/fake_notifier_test.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Widget buildApp({DashboardNotifier? notifier}) {
    return ProviderScope(
      overrides: [
        dashboardNotifierProvider.overrideWith(
          () => notifier ?? FakeDashboardNotifier(),
        ),
      ],
      child: const MaterialApp(home: DashboardScreen()),
    );
  }

  group('Dashboard Integration Tests', () {
    testWidgets('app launches and displays movie grid', (tester) async {
      await tester.pumpWidget(buildApp(notifier: FakeDashboardNotifier()));
      await tester.pumpAndSettle();

      expect(find.byKey(KeyConstants.movieGrid), findsOneWidget);
      expect(find.text('Avengers'), findsOneWidget);
      expect(find.text('Spider-Man'), findsOneWidget);
    });

    testWidgets('tapping movie navigates to detail screen', (tester) async {
      await tester.pumpWidget(buildApp(notifier: FakeDashboardNotifier()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('movie_card_1')));
      await tester.pumpAndSettle();

      expect(find.byType(Detailscreen), findsOneWidget);
    });

    testWidgets('back button returns to dashboard', (tester) async {
      await tester.pumpWidget(buildApp(notifier: FakeDashboardNotifier()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('movie_card_1')));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(find.byKey(KeyConstants.movieGrid), findsOneWidget);
    });

    testWidgets('switching tabs loads different content', (tester) async {
      await tester.pumpWidget(buildApp(notifier: FakeDashboardNotifier()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Top Rated'));
      await tester.pumpAndSettle();
      expect(find.byKey(KeyConstants.movieGrid), findsOneWidget);

      await tester.tap(find.text('Popular'));
      await tester.pumpAndSettle();
      expect(find.byKey(KeyConstants.movieGrid), findsOneWidget);
    });

    testWidgets('pull to refresh reloads movies', (tester) async {
      await tester.pumpWidget(buildApp(notifier: FakeDashboardNotifier()));
      await tester.pumpAndSettle();

      await tester.fling(
        find.byKey(KeyConstants.movieGrid),
        const Offset(0, 300),
        1000,
      );
      await tester.pumpAndSettle();

      expect(find.byKey(KeyConstants.movieGrid), findsOneWidget);
    });

    testWidgets('shows error message when fetch fails', (tester) async {
      await tester.pumpWidget(buildApp(notifier: FakeErrorNotifier()));
      await tester.pumpAndSettle();

      expect(find.byKey(KeyConstants.errorText), findsOneWidget);
    });

    testWidgets('shows no data when results are empty', (tester) async {
      await tester.pumpWidget(buildApp(notifier: FakeEmptyNotifier()));
      await tester.pumpAndSettle();

      expect(find.byKey(KeyConstants.noDataText), findsOneWidget);
    });

    testWidgets('scrolling to bottom triggers pagination', (tester) async {
      await tester.pumpWidget(buildApp(notifier: FakeDashboardNotifier()));
      await tester.pumpAndSettle();

      await tester.fling(
        find.byKey(KeyConstants.movieGrid),
        const Offset(0, -500),
        1000,
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsAny);
    });
  });
}
