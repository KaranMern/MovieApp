import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/core/network/alice_provider.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/presentation/Screens/dashboard.dart';
import 'package:sample/features/movies/presentation/Screens/detail_screen.dart';

/// Provides the app [GoRouter] with initial route `/home`, optional Alice
/// navigator key for SIT, and routes for dashboard and detail screen.
final appRouterProvider = Provider<GoRouter>((ref) {
  final alice = ref.read(aliceProvider); // ✅ READ

  return GoRouter(
    initialLocation: '/home',
    navigatorKey: alice?.getNavigatorKey(),
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/DetailScreen',
        builder: (context, state) {
          final result = state.extra! as ResultEntity;
          return Detailscreen(result: result);
        },
      ),
    ],
  );
});