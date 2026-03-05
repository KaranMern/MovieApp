// test/presentation/screens/detail_screen_test.dart

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

/// Wraps [Detailscreen] in a [GoRouter] with home and detail routes so
/// [context.pop()] works. Optionally sets [screenSize] via [MediaQuery].
Widget _wrapWithRouter(ResultEntity result, {Size? screenSize}) {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (_, __) => const Scaffold(body: Text('Home')),
      ),
      GoRoute(
        path: '/detail',
        builder: (_, __) => Detailscreen(result: result),
      ),
    ],
  );

  Widget app = MaterialApp.router(routerConfig: router);

  if (screenSize != null) {
    app = MediaQuery(
      data: MediaQueryData(size: screenSize),
      child: app,
    );
  }

  return ProviderScope(child: app);
}

void main() {
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

  group('Detailscreen Widget Tests', () {
    testWidgets('renders Scaffold and AppBar with correct title',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
            child: MaterialApp(home: Detailscreen(result: tResult))),
      );
      await tester.pumpAndSettle();

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

      await tester.pumpWidget(
        const ProviderScope(
            child: MaterialApp(home: Detailscreen(result: tResult))),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MobileLayout), findsOneWidget);
      expect(find.byType(TabletLayout), findsNothing);
    });

    testWidgets('renders TabletLayout on large screens', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const ProviderScope(
            child: MaterialApp(home: Detailscreen(result: tResult))),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TabletLayout), findsOneWidget);
      expect(find.byType(MobileLayout), findsNothing);
    });

    testWidgets('back button triggers pop', (tester) async {
      final router = GoRouter(
        initialLocation: '/home',
        routes: [
          GoRoute(
            path: '/home',
            builder: (_, __) => const Scaffold(body: Text('Home')),
          ),
          GoRoute(
            path: '/detail',
            builder: (_, __) => const Detailscreen(result: tResult),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      router.push('/detail');
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
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

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Detailscreen(result: resultWithNullId)),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Unknown'), findsOneWidget);
    });
  });

  group('MobileLayout Widget Tests', () {
    testWidgets('renders ImageHeader and DetailScreen_Footer', (tester) async {
      await tester.pumpWidget(
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
      await tester.pumpAndSettle();

      expect(find.byType(ImageHeader), findsOneWidget);
      expect(find.byType(DetailScreen_Footer), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });

  group('TabletLayout Widget Tests', () {
    testWidgets('renders ImageHeader and DetailScreen_Footer in Row',
        (tester) async {
      await tester.pumpWidget(
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
      await tester.pumpAndSettle();

      expect(find.byType(ImageHeader), findsOneWidget);
      expect(find.byType(DetailScreen_Footer), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
