// test/presentation/screens/detail_screen_test.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/presentation/Screens/detail_screen.dart';
import 'package:sample/features/movies/presentation/widgets/custom_mobile_layout.dart';
import 'package:sample/features/movies/presentation/widgets/custom_tablet_layout.dart';
import 'package:sample/features/movies/presentation/widgets/detail_screen_footer.dart';
import 'package:sample/features/movies/presentation/widgets/details_screen_header.dart';

// Intercepts all HTTP image requests and returns a 1x1 transparent PNG,
// preventing network calls that cause pumpAndSettle to hang forever.
class _FakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    // Return a minimal 1x1 transparent PNG for every image request
    // so Image.network / CachedNetworkImage resolves immediately.
    return client;
  }
}

void main() {
  // Swap out real HTTP with a fake that returns instantly
  setUpAll(() {
    HttpOverrides.global = _FakeHttpOverrides();
  });

  const tResult = ResultEntity(
    id: 42,
    title: 'Test Movie',
    posterPath: '/poster.jpg',
    releaseDate: '2024-01-01',
    voteAverage: 8,
    adult: false,
    video: false,
    genreIds: [28],
    popularity: 9,
  );

  // Helper: pump widget with a timeout-safe settle
  Future<void> pumpWidget(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(widget);
    // Use pump with duration instead of pumpAndSettle to avoid
    // infinite loops caused by unresolved network image animations
    await tester.pump(const Duration(seconds: 3));
  }

  group('Detailscreen Widget Tests', () {
    testWidgets('renders Scaffold and AppBar with correct title', (
      tester,
    ) async {
      await pumpWidget(
        tester,
        const ProviderScope(
          child: MaterialApp(home: Detailscreen(result: tResult)),
        ),
      );

      expect(find.byType(Scaffold), findsWidgets);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('42'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
    });

    testWidgets('renders MobileLayout on small screens', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await pumpWidget(
        tester,
        const ProviderScope(
          child: MaterialApp(home: Detailscreen(result: tResult)),
        ),
      );

      expect(find.byType(MobileLayout), findsOneWidget);
      expect(find.byType(TabletLayout), findsNothing);
    });

    testWidgets('renders TabletLayout on large screens', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await pumpWidget(
        tester,
        const ProviderScope(
          child: MaterialApp(home: Detailscreen(result: tResult)),
        ),
      );

      expect(find.byType(TabletLayout), findsOneWidget);
      expect(find.byType(MobileLayout), findsNothing);
    });

    testWidgets('back button triggers pop', (tester) async {
      final router = GoRouter(
        initialLocation: '/home',
        routes: [
          GoRoute(
            path: '/home',
            builder: (_, __) => Scaffold(
              body: Builder(
                builder: (ctx) => TextButton(
                  onPressed: () => ctx.push('/detail'),
                  child: const Text('Go to Detail'),
                ),
              ),
            ),
          ),
          GoRoute(
            path: '/detail',
            builder: (_, __) => const Detailscreen(result: tResult),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(child: MaterialApp.router(routerConfig: router)),
      );
      await tester.pump(); // initial frame

      // Navigate to detail
      await tester.tap(find.text('Go to Detail'));
      await tester.pump(); // start transition
      await tester.pump(const Duration(milliseconds: 500)); // finish transition

      // Pump repeatedly until icon appears (max 5 seconds)
      for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 500));
        if (find.byIcon(Icons.arrow_back_ios).evaluate().isNotEmpty) break;
      }

      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Go to Detail'), findsOneWidget);
    });
    testWidgets('renders fallback text if result.id is null', (tester) async {
      const resultWithNullId = ResultEntity(
        title: 'No ID Movie',
        posterPath: '/poster.jpg',
        releaseDate: '2024-01-01',
        voteAverage: 7,
        adult: false,
        video: false,
        genreIds: [],
        popularity: 5,
      );

      await pumpWidget(
        tester,
        const ProviderScope(
          child: MaterialApp(home: Detailscreen(result: resultWithNullId)),
        ),
      );

      expect(find.text('Unknown'), findsOneWidget);
    });
  });

  group('MobileLayout Widget Tests', () {
    testWidgets('renders ImageHeader and DetailScreen_Footer', (tester) async {
      await pumpWidget(
        tester,
        MaterialApp(
          home: Scaffold(
            body: MobileLayout(
              result: tResult,
              textTheme: ThemeData.light().textTheme,
              colors: ThemeData.light().colorScheme,
            ),
          ),
        ),
      );

      expect(find.byType(ImageHeader), findsOneWidget);
      expect(find.byType(DetailScreen_Footer), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });

  group('TabletLayout Widget Tests', () {
    testWidgets('renders ImageHeader and DetailScreen_Footer in Row', (
      tester,
    ) async {
      await pumpWidget(
        tester,
        MaterialApp(
          home: Scaffold(
            body: TabletLayout(
              result: tResult,
              textTheme: ThemeData.light().textTheme,
              colors: ThemeData.light().colorScheme,
            ),
          ),
        ),
      );

      expect(find.byType(ImageHeader), findsOneWidget);
      expect(find.byType(DetailScreen_Footer), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
